import StoreKit
import UIKit
import WebKit

final class HavraShellJaonController: UIViewController, WKNavigationDelegate, WKScriptMessageHandler {
    private static let runtimeScheme = "havra-runtime"
    private static let runtimeHost = "app"
    private static let orchardBridgeName = "PoetryIAP"

    private var didOpenHavraAtlas = false
    private let atlasRouteHandler = HavraAtlasRouteHandler()
    private lazy var scriptCourier = HavraScriptCourier(receiver: self)

    private lazy var havraCanvas: WKWebView = {
        let configuration = makeAtlasConfiguration()
        let atlasSurface = WKWebView(frame: .zero, configuration: configuration)
        return prepareAtlasSurface(atlasSurface)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.0, green: 0.07, blue: 0.06, alpha: 1.0)
        connectAtlasChannels()
        installAtlasSurface()
        observeOrchardReceipts()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard !didOpenHavraAtlas else { return }
        didOpenHavraAtlas = true
        openHavraAtlas()
    }

    deinit {
        let scriptCenter = havraCanvas.configuration.userContentController
        scriptCenter.removeScriptMessageHandler(forName: Self.orchardBridgeName)
        NotificationCenter.default.removeObserver(self)
    }

    private func makeAtlasConfiguration() -> WKWebViewConfiguration {
        let configuration = WKWebViewConfiguration()
        configuration.setURLSchemeHandler(atlasRouteHandler, forURLScheme: Self.runtimeScheme)
        configuration.userContentController.addUserScript(HavraHarvestLedger.fetchScript)
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
        return configuration
    }

    private func prepareAtlasSurface(_ atlasSurface: WKWebView) -> WKWebView {
        let background = UIColor(red: 0.0, green: 0.07, blue: 0.06, alpha: 1.0)
        atlasSurface.translatesAutoresizingMaskIntoConstraints = false
        atlasSurface.navigationDelegate = self
        atlasSurface.isOpaque = false
        atlasSurface.backgroundColor = background
        atlasSurface.scrollView.backgroundColor = background
        atlasSurface.scrollView.contentInsetAdjustmentBehavior = .never
        atlasSurface.allowsBackForwardNavigationGestures = true
        return atlasSurface
    }

    private func connectAtlasChannels() {
        let scriptCenter = havraCanvas.configuration.userContentController
        scriptCenter.add(scriptCourier, name: Self.orchardBridgeName)
    }

    private func installAtlasSurface() {
        view.addSubview(havraCanvas)
        NSLayoutConstraint.activate([
            havraCanvas.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            havraCanvas.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            havraCanvas.topAnchor.constraint(equalTo: view.topAnchor),
            havraCanvas.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func observeOrchardReceipts() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleOrchardReceiptNotice(_:)),
            name: .havraOrchardReceiptArrived,
            object: nil
        )
    }

    @objc private func handleOrchardReceiptNotice(_ notice: Notification) {
        guard let receipt = notice.object as? Transaction,
              HavraHarvestLedger.approvedIDs.contains(receipt.productID) else {
            return
        }

        Task { @MainActor [weak self] in
            await receipt.finish()
            self?.sendOrchardResult([
                "status": "success",
                "product_id": receipt.productID,
                "package_id": receipt.productID,
                "transaction_id": String(receipt.id),
                "allow_transaction_fallback": true
            ])
        }
    }

    private func openHavraAtlas() {
        guard HavraHarvestLedger.resourceURL("index.html") != nil,
              let runtimeURL = URL(string: "\(Self.runtimeScheme)://\(Self.runtimeHost)/index.html#/") else {
            showStartupFallback("Havra content is unavailable.")
            return
        }

        havraCanvas.load(URLRequest(url: runtimeURL))
    }

    private func showStartupFallback(_ noticeText: String) {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = noticeText
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .body)
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func userContentController(
        _ userContentController: WKUserContentController,
        didReceive scriptPacket: WKScriptMessage
    ) {
        guard scriptPacket.name == Self.orchardBridgeName,
              let packet = scriptPacket.body as? [String: Any] else {
            return
        }

        handleOrchardPacket(packet)
    }

    func webView(_ atlasSurface: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showStartupFallback("Havra content could not be opened.")
        print("Havra web navigation failed:", error.localizedDescription)
    }

    func webView(_ atlasSurface: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        showStartupFallback("Havra content could not be opened.")
        print("Havra web provisional navigation failed:", error.localizedDescription)
    }

    private func handleOrchardPacket(_ packet: [String: Any]) {
        let requestType = Self.trimmedString(packet["type"])
        switch requestType {
        case "startPurchase":
            Task { @MainActor [weak self] in
                await self?.openHarvestBundle(from: packet)
            }
        case "restorePurchases", "startRestore", "restore":
            Task { @MainActor [weak self] in
                await self?.restoreHarvestBundles(trailRequestID: Self.trimmedString(packet["request_id"]) ?? "")
            }
        default:
            sendOrchardResult([
                "status": "failed",
                "request_id": Self.trimmedString(packet["request_id"]) ?? "",
                "message": "Unsupported purchase request."
            ])
        }
    }

    @MainActor
    private func openHarvestBundle(from packet: [String: Any]) async {
        let packetData = packet["data"] as? [String: Any]
        let trailRequestID = Self.trimmedString(packet["request_id"])
            ?? Self.trimmedString(packetData?["request_id"])
            ?? ""
        let orchardItemID = Self.trimmedString(packet["productId"])
            ?? Self.trimmedString(packet["product_id"])
            ?? Self.trimmedString(packetData?["product_id"])
            ?? Self.trimmedString(packetData?["package_id"])
            ?? ""
        let harvestBundleID = Self.trimmedString(packetData?["package_id"])
            ?? Self.trimmedString(packet["package_id"])
            ?? orchardItemID
        let travelerID = Self.trimmedString(packet["user_id"])
            ?? Self.trimmedString(packetData?["user_id"])
            ?? ""

        guard !orchardItemID.isEmpty else {
            sendOrchardFailure(trailRequestID: trailRequestID, harvestBundleID: harvestBundleID, noticeText: "Product identifier is missing.")
            return
        }

        guard HavraHarvestLedger.approvedIDs.contains(orchardItemID) else {
            sendOrchardFailure(trailRequestID: trailRequestID, harvestBundleID: harvestBundleID, noticeText: "This product is not configured for Havra.")
            return
        }

        do {
            guard let orchardItem = try await Product.products(for: [orchardItemID]).first else {
                sendOrchardFailure(trailRequestID: trailRequestID, harvestBundleID: harvestBundleID, noticeText: "This product is unavailable from the App Store.")
                return
            }

            switch try await orchardItem.purchase() {
            case .success(let verification):
                let receipt = try Self.verifiedReceipt(from: verification)
                guard receipt.productID == orchardItemID else {
                    throw HavraOrchardError.orchardItemMismatch
                }

                await receipt.finish()
                let harvestBundle = HavraHarvestLedger.bundle(for: orchardItemID)
                sendOrchardResult([
                    "status": "success",
                    "request_id": trailRequestID,
                    "product_id": orchardItemID,
                    "package_id": harvestBundleID,
                    "coin_count": HavraHarvestLedger.sunCount(in: harvestBundle),
                    "transaction_id": String(receipt.id),
                    "user_id": travelerID,
                    "allow_transaction_fallback": true
                ])
            case .pending:
                sendOrchardFailure(trailRequestID: trailRequestID, harvestBundleID: harvestBundleID, noticeText: "The App Store purchase is pending approval.")
            case .userCancelled:
                sendOrchardFailure(trailRequestID: trailRequestID, harvestBundleID: harvestBundleID, noticeText: "The purchase was cancelled.")
            @unknown default:
                sendOrchardFailure(trailRequestID: trailRequestID, harvestBundleID: harvestBundleID, noticeText: "The App Store returned an unknown purchase state.")
            }
        } catch {
            sendOrchardFailure(trailRequestID: trailRequestID, harvestBundleID: harvestBundleID, noticeText: Self.orchardNotice(for: error))
        }
    }

    @MainActor
    private func restoreHarvestBundles(trailRequestID: String) async {
        var restoredBundles: [[String: Any]] = []

        for await verification in Transaction.currentEntitlements {
            guard case .verified(let receipt) = verification,
                  HavraHarvestLedger.approvedIDs.contains(receipt.productID) else {
                continue
            }

            let harvestBundle = HavraHarvestLedger.bundle(for: receipt.productID)
            restoredBundles.append([
                "status": "success",
                "request_id": trailRequestID,
                "product_id": receipt.productID,
                "package_id": receipt.productID,
                "coin_count": HavraHarvestLedger.sunCount(in: harvestBundle),
                "transaction_id": String(receipt.id),
                "allow_transaction_fallback": true
            ])
        }

        sendOrchardResult([
            "status": "success",
            "request_id": trailRequestID,
            "purchases": restoredBundles,
            "restored_purchases": restoredBundles
        ])
    }

    private func sendOrchardFailure(trailRequestID: String, harvestBundleID: String, noticeText: String) {
        sendOrchardResult([
            "status": "failed",
            "request_id": trailRequestID,
            "package_id": harvestBundleID,
            "message": noticeText,
            "error_message": noticeText
        ])
    }

    private func sendOrchardResult(_ packet: [String: Any]) {
        guard JSONSerialization.isValidJSONObject(packet),
              let packetData = try? JSONSerialization.data(withJSONObject: packet),
              let packetJSON = String(data: packetData, encoding: .utf8) else {
            return
        }

        let relayScript = """
        (function() {
          var harvestPacket = \(packetJSON);
          if (window.PoetryIAP && typeof window.PoetryIAP.receive === 'function') {
            window.PoetryIAP.receive(harvestPacket);
          }
          window.dispatchEvent(new CustomEvent('poetry-iap-result', { detail: harvestPacket }));
        })();
        """
        havraCanvas.evaluateJavaScript(relayScript)
    }

    private static func verifiedReceipt<T>(from verification: VerificationResult<T>) throws -> T {
        switch verification {
        case .verified(let receipt):
            return receipt
        case .unverified:
            throw HavraOrchardError.unverifiedReceipt
        }
    }

    private static func trimmedString(_ value: Any?) -> String? {
        guard let text = value as? String else { return nil }
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? nil : trimmed
    }

    private static func orchardNotice(for error: Error) -> String {
        if error is HavraOrchardError {
            return "The App Store transaction could not be verified."
        }

        let nsError = error as NSError
        if nsError.domain == SKError.errorDomain,
           let storeError = SKError.Code(rawValue: nsError.code) {
            switch storeError {
            case .paymentNotAllowed:
                return "App Store purchases are disabled on this device."
            case .storeProductNotAvailable:
                return "This product is unavailable from the App Store."
            default:
                break
            }
        }

        if nsError.domain == NSURLErrorDomain {
            return "Unable to connect to the App Store."
        }

        return error.localizedDescription
    }

    private enum HavraOrchardError: Error {
        case orchardItemMismatch
        case unverifiedReceipt
    }
}
