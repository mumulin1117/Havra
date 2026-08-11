import Foundation
import WebKit

enum HavraHarvestLedger {
    private static let freshLedgerPath = "havra-atlas/catalog-config/harvest-ledger.json"
    private static let legacyLedgerPath = "havra-atlas/catalog-config/coin-packages.json"

    static let approvedIDs: Set<String> = {
        Set(catalog.compactMap { bundle in
            orchardItemID(in: bundle) ?? bundleID(in: bundle)
        })
    }()

    static let fetchScript: WKUserScript = {
        let bridgeJSON = bridgeLedgerJSON
        guard !bridgeJSON.isEmpty else {
            return WKUserScript(source: "", injectionTime: .atDocumentStart, forMainFrameOnly: true)
        }

        return WKUserScript(
            source: """
            (function() {
              var havraHarvestLedger = \(bridgeJSON);
              var nativeFetch = window.fetch ? window.fetch.bind(window) : null;
              window.fetch = function(atlasTarget, fetchOptions) {
                var atlasAddress = typeof atlasTarget === 'string'
                  ? atlasTarget
                  : (atlasTarget && atlasTarget.url ? atlasTarget.url : '');
                var harvestRoutes = [
                  '\(freshLedgerPath)',
                  '\(legacyLedgerPath)'
                ];

                if (harvestRoutes.some(function(atlasPath) {
                  return atlasAddress.indexOf(atlasPath) !== -1;
                })) {
                  return Promise.resolve(new Response(
                    JSON.stringify(havraHarvestLedger),
                    {
                      status: 200,
                      headers: { 'Content-Type': 'application/json' }
                    }
                  ));
                }

                if (nativeFetch) return nativeFetch(atlasTarget, fetchOptions);
                return Promise.reject(new Error('Fetch is unavailable.'));
              };
            })();
            """,
            injectionTime: .atDocumentStart,
            forMainFrameOnly: true
        )
    }()

    static func resourceURL(_ relativePath: String) -> URL? {
        bundleRootURL?.appendingPathComponent(HavraAtlasPathGuide.atlasPath(for: relativePath))
    }

    static func bundle(for orchardItemID: String) -> [String: Any]? {
        catalog.first { bundle in
            Self.orchardItemID(in: bundle) == orchardItemID || Self.bundleID(in: bundle) == orchardItemID
        }
    }

    static func sunCount(in bundle: [String: Any]?) -> Any {
        guard let bundle else { return 0 }
        return bundle["sun_count"] ?? bundle["coin_count"] ?? 0
    }

    private static let bundleRootURL: URL? = {
        Bundle.main.url(forResource: "HavraWebRuntime", withExtension: "bundle")
    }()

    private static let root: [String: Any] = {
        guard let ledgerURL = resourceURL(freshLedgerPath),
              let ledgerData = try? Data(contentsOf: ledgerURL),
              let ledgerRoot = try? JSONSerialization.jsonObject(with: ledgerData) as? [String: Any] else {
            return [:]
        }

        return ledgerRoot
    }()

    private static let catalog: [[String: Any]] = {
        root["harvest_bundles"] as? [[String: Any]] ?? []
    }()

    private static let bridgeLedgerJSON: String = {
        let bundles = catalog.map { bundle in
            [
                "package_id": bundleID(in: bundle) ?? "",
                "product_id": orchardItemID(in: bundle) ?? "",
                "package_name": bundleTitle(in: bundle),
                "coin_count": sunCount(in: bundle),
                "price_text": amountText(in: bundle),
                "coin_icon_url": sunMarkURL(in: bundle),
                "is_popular": featuredFlag(in: bundle)
            ]
        }

        let bridgeRoot: [String: Any] = [
            "version": root["version"] ?? 1,
            "coin_packages": bundles
        ]

        guard JSONSerialization.isValidJSONObject(bridgeRoot),
              let bridgeData = try? JSONSerialization.data(withJSONObject: bridgeRoot),
              let bridgeJSON = String(data: bridgeData, encoding: .utf8) else {
            return #"{"version":1,"coin_packages":[]}"#
        }

        return bridgeJSON
    }()

    private static func bundleID(in bundle: [String: Any]) -> String? {
        trimmedString(bundle["bundle_id"]) ?? trimmedString(bundle["package_id"])
    }

    private static func orchardItemID(in bundle: [String: Any]) -> String? {
        trimmedString(bundle["orchard_item_id"]) ?? trimmedString(bundle["product_id"])
    }

    private static func bundleTitle(in bundle: [String: Any]) -> String {
        trimmedString(bundle["bundle_title"]) ?? trimmedString(bundle["package_name"]) ?? ""
    }

    private static func amountText(in bundle: [String: Any]) -> String {
        trimmedString(bundle["amount_text"]) ?? trimmedString(bundle["price_text"]) ?? ""
    }

    private static func sunMarkURL(in bundle: [String: Any]) -> String {
        trimmedString(bundle["sun_mark_url"]) ?? trimmedString(bundle["coin_icon_url"]) ?? ""
    }

    private static func featuredFlag(in bundle: [String: Any]) -> Any {
        bundle["featured"] ?? bundle["is_popular"] ?? false
    }

    private static func trimmedString(_ value: Any?) -> String? {
        guard let text = value as? String else { return nil }
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? nil : trimmed
    }
}
