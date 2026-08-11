import StoreKit
import UIKit
import WebKit

final class HavraShellJaonController: UIViewController, WKNavigationDelegate, WKScriptMessageHandler {
    private static let runtimeScheme = HavraOrchardLexicon.runtimeScheme
    private static let runtimeHost = HavraOrchardLexicon.runtimeHost
    private static let orchardBridgeName = HavraOrchardLexicon.bridgeName

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
                HavraOrchardLexicon.stateKey: HavraOrchardLexicon.okMark,
                HavraOrchardLexicon.orchardIDKey: receipt.productID,
                HavraOrchardLexicon.bundleIDKey: receipt.productID,
                HavraOrchardLexicon.receiptKey: String(receipt.id),
                HavraOrchardLexicon.fallbackKey: true
            ])
        }
    }

    private func openHavraAtlas() {
        guard HavraHarvestLedger.resourceURL(HavraOrchardLexicon.indexFile) != nil,
              let runtimeURL = URL(string: Self.runtimeScheme + HavraOrchardLexicon.startPath) else {
            showStartupFallback(HavraOrchardLexicon.cantFind)
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
        showStartupFallback(HavraOrchardLexicon.cantOpen)
        print(HavraOrchardLexicon.navLog, error.localizedDescription)
    }

    func webView(_ atlasSurface: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        showStartupFallback(HavraOrchardLexicon.cantOpen)
        print(HavraOrchardLexicon.provLog, error.localizedDescription)
    }

    private func handleOrchardPacket(_ packet: [String: Any]) {
        let requestType = Self.trimmedString(packet[HavraOrchardLexicon.typeKey])
        switch requestType {
        case HavraOrchardLexicon.beginSignal:
            Task { @MainActor [weak self] in
                await self?.openHarvestBundle(from: packet)
            }
        case HavraOrchardLexicon.renewSignalA, HavraOrchardLexicon.renewSignalB, HavraOrchardLexicon.renewSignalC:
            Task { @MainActor [weak self] in
                await self?.restoreHarvestBundles(trailRequestID: Self.trimmedString(packet[HavraOrchardLexicon.requestKey]) ?? "")
            }
        default:
            sendOrchardResult([
                HavraOrchardLexicon.stateKey: HavraOrchardLexicon.badMark,
                HavraOrchardLexicon.requestKey: Self.trimmedString(packet[HavraOrchardLexicon.requestKey]) ?? "",
                HavraOrchardLexicon.noticeKey: HavraOrchardLexicon.unsupported
            ])
        }
    }

    @MainActor
    private func openHarvestBundle(from packet: [String: Any]) async {
        let packetData = packet[HavraOrchardLexicon.dataKey] as? [String: Any]
        let trailRequestID = Self.trimmedString(packet[HavraOrchardLexicon.requestKey])
            ?? Self.trimmedString(packetData?[HavraOrchardLexicon.requestKey])
            ?? ""
        let orchardItemID = Self.trimmedString(packet[HavraOrchardLexicon.camelOrchardKey])
            ?? Self.trimmedString(packet[HavraOrchardLexicon.orchardIDKey])
            ?? Self.trimmedString(packetData?[HavraOrchardLexicon.orchardIDKey])
            ?? Self.trimmedString(packetData?[HavraOrchardLexicon.bundleIDKey])
            ?? ""
        let harvestBundleID = Self.trimmedString(packetData?[HavraOrchardLexicon.bundleIDKey])
            ?? Self.trimmedString(packet[HavraOrchardLexicon.bundleIDKey])
            ?? orchardItemID
        let travelerID = Self.trimmedString(packet[HavraOrchardLexicon.travelerKey])
            ?? Self.trimmedString(packetData?[HavraOrchardLexicon.travelerKey])
            ?? ""

        guard !orchardItemID.isEmpty else {
            sendOrchardFailure(trailRequestID: trailRequestID, harvestBundleID: harvestBundleID, noticeText: HavraOrchardLexicon.missingID)
            return
        }

        guard HavraHarvestLedger.approvedIDs.contains(orchardItemID) else {
            sendOrchardFailure(trailRequestID: trailRequestID, harvestBundleID: harvestBundleID, noticeText: HavraOrchardLexicon.notReady)
            return
        }

        do {
            guard let orchardItem = try await Product.products(for: [orchardItemID]).first else {
                sendOrchardFailure(trailRequestID: trailRequestID, harvestBundleID: harvestBundleID, noticeText: HavraOrchardLexicon.notFound)
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
                    HavraOrchardLexicon.stateKey: HavraOrchardLexicon.okMark,
                    HavraOrchardLexicon.requestKey: trailRequestID,
                    HavraOrchardLexicon.orchardIDKey: orchardItemID,
                    HavraOrchardLexicon.bundleIDKey: harvestBundleID,
                    HavraOrchardLexicon.sunCountKey: HavraHarvestLedger.sunCount(in: harvestBundle),
                    HavraOrchardLexicon.receiptKey: String(receipt.id),
                    HavraOrchardLexicon.travelerKey: travelerID,
                    HavraOrchardLexicon.fallbackKey: true
                ])
            case .pending:
                sendOrchardFailure(trailRequestID: trailRequestID, harvestBundleID: harvestBundleID, noticeText: HavraOrchardLexicon.pending)
            case .userCancelled:
                sendOrchardFailure(trailRequestID: trailRequestID, harvestBundleID: harvestBundleID, noticeText: HavraOrchardLexicon.cancelled)
            @unknown default:
                sendOrchardFailure(trailRequestID: trailRequestID, harvestBundleID: harvestBundleID, noticeText: HavraOrchardLexicon.unknown)
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
                HavraOrchardLexicon.stateKey: HavraOrchardLexicon.okMark,
                HavraOrchardLexicon.requestKey: trailRequestID,
                HavraOrchardLexicon.orchardIDKey: receipt.productID,
                HavraOrchardLexicon.bundleIDKey: receipt.productID,
                HavraOrchardLexicon.sunCountKey: HavraHarvestLedger.sunCount(in: harvestBundle),
                HavraOrchardLexicon.receiptKey: String(receipt.id),
                HavraOrchardLexicon.fallbackKey: true
            ])
        }

        sendOrchardResult([
            HavraOrchardLexicon.stateKey: HavraOrchardLexicon.okMark,
            HavraOrchardLexicon.requestKey: trailRequestID,
            HavraOrchardLexicon.restoredListKey: restoredBundles,
            HavraOrchardLexicon.restoredMirrorKey: restoredBundles
        ])
    }

    private func sendOrchardFailure(trailRequestID: String, harvestBundleID: String, noticeText: String) {
        sendOrchardResult([
            HavraOrchardLexicon.stateKey: HavraOrchardLexicon.badMark,
            HavraOrchardLexicon.requestKey: trailRequestID,
            HavraOrchardLexicon.bundleIDKey: harvestBundleID,
            HavraOrchardLexicon.noticeKey: noticeText,
            HavraOrchardLexicon.errorNoticeKey: noticeText
        ])
    }

    private func sendOrchardResult(_ packet: [String: Any]) {
        guard JSONSerialization.isValidJSONObject(packet),
              let packetData = try? JSONSerialization.data(withJSONObject: packet),
              let packetJSON = String(data: packetData, encoding: .utf8) else {
            return
        }

        let relayScript = HavraOrchardLexicon.relayScript
            .replacingOccurrences(of: HavraOrchardLexicon.packetToken, with: packetJSON)
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
            return HavraOrchardLexicon.unverified
        }

        let nsError = error as NSError
        if nsError.domain == SKError.errorDomain,
           let storeError = SKError.Code(rawValue: nsError.code) {
            switch storeError {
            case .paymentNotAllowed:
                return HavraOrchardLexicon.disabled
            case .storeProductNotAvailable:
                return HavraOrchardLexicon.notFound
            default:
                break
            }
        }

        if nsError.domain == NSURLErrorDomain {
            return HavraOrchardLexicon.network
        }

        return error.localizedDescription
    }

    private enum HavraOrchardError: Error {
        case orchardItemMismatch
        case unverifiedReceipt
    }
}
