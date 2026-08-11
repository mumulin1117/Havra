import StoreKit
import UIKit
import WebKit

final class HavraCommunityShellController: UIViewController, WKNavigationDelegate, WKScriptMessageHandler {
    private static let runtimeScheme = "havra-runtime"
    private static let runtimeHost = "app"
    private static let purchaseBridgeName = "PoetryIAP"
    private static let coinCatalogRelativePath = "static/common.config/coin-packages.json"

    private var didLoadCommunityRuntime = false
    private let runtimeSchemeHandler = HavraRuntimeSchemeHandler()
    private lazy var scriptRelay = HavraWebScriptRelay(recipient: self)

    private lazy var communityWebView: WKWebView = {
        let configuration = makeWebConfiguration()
        let webView = WKWebView(frame: .zero, configuration: configuration)
        return prepareWebView(webView)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.0, green: 0.07, blue: 0.06, alpha: 1.0)
        connectWebChannels()
        installWebView()
        observeStoreTransactions()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard !didLoadCommunityRuntime else { return }
        didLoadCommunityRuntime = true
        loadCommunityRuntime()
    }

    deinit {
        let controller = communityWebView.configuration.userContentController
        controller.removeScriptMessageHandler(forName: Self.purchaseBridgeName)
        NotificationCenter.default.removeObserver(self)
    }

    private func makeWebConfiguration() -> WKWebViewConfiguration {
        let configuration = WKWebViewConfiguration()
        configuration.setURLSchemeHandler(runtimeSchemeHandler, forURLScheme: Self.runtimeScheme)
        configuration.userContentController.addUserScript(Self.coinCatalogFetchScript)
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
        return configuration
    }

    private func prepareWebView(_ webView: WKWebView) -> WKWebView {
        let background = UIColor(red: 0.0, green: 0.07, blue: 0.06, alpha: 1.0)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        webView.isOpaque = false
        webView.backgroundColor = background
        webView.scrollView.backgroundColor = background
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }

    private func connectWebChannels() {
        let controller = communityWebView.configuration.userContentController
        controller.add(scriptRelay, name: Self.purchaseBridgeName)
    }

    private func installWebView() {
        view.addSubview(communityWebView)
        NSLayoutConstraint.activate([
            communityWebView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            communityWebView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            communityWebView.topAnchor.constraint(equalTo: view.topAnchor),
            communityWebView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func observeStoreTransactions() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleStoreTransactionNotification(_:)),
            name: .havraStoreTransactionUpdated,
            object: nil
        )
    }

    @objc private func handleStoreTransactionNotification(_ notification: Notification) {
        guard let transaction = notification.object as? Transaction,
              Self.approvedProductIDs.contains(transaction.productID) else {
            return
        }

        Task { @MainActor [weak self] in
            await transaction.finish()
            self?.sendPurchaseResult([
                "status": "success",
                "product_id": transaction.productID,
                "package_id": transaction.productID,
                "transaction_id": String(transaction.id),
                "allow_transaction_fallback": true
            ])
        }
    }

    private func loadCommunityRuntime() {
        guard Self.runtimeResourceURL("index.html") != nil,
              let runtimeURL = URL(string: "\(Self.runtimeScheme)://\(Self.runtimeHost)/index.html#/") else {
            showStartupFallback("Havra content is unavailable.")
            return
        }

        communityWebView.load(URLRequest(url: runtimeURL))
    }

    private func showStartupFallback(_ message: String) {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = message
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
        didReceive message: WKScriptMessage
    ) {
        guard message.name == Self.purchaseBridgeName,
              let payload = message.body as? [String: Any] else {
            return
        }

        handlePurchasePayload(payload)
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showStartupFallback("Havra content could not be opened.")
        print("Havra web navigation failed:", error.localizedDescription)
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        showStartupFallback("Havra content could not be opened.")
        print("Havra web provisional navigation failed:", error.localizedDescription)
    }

    private func handlePurchasePayload(_ payload: [String: Any]) {
        let requestType = Self.trimmedString(payload["type"])
        switch requestType {
        case "startPurchase":
            Task { @MainActor [weak self] in
                await self?.purchaseCoinPackage(from: payload)
            }
        case "restorePurchases", "startRestore", "restore":
            Task { @MainActor [weak self] in
                await self?.restoreCoinPackages(requestID: Self.trimmedString(payload["request_id"]) ?? "")
            }
        default:
            sendPurchaseResult([
                "status": "failed",
                "request_id": Self.trimmedString(payload["request_id"]) ?? "",
                "message": "Unsupported purchase request."
            ])
        }
    }

    @MainActor
    private func purchaseCoinPackage(from payload: [String: Any]) async {
        let data = payload["data"] as? [String: Any]
        let requestID = Self.trimmedString(payload["request_id"])
            ?? Self.trimmedString(data?["request_id"])
            ?? ""
        let productID = Self.trimmedString(payload["productId"])
            ?? Self.trimmedString(payload["product_id"])
            ?? Self.trimmedString(data?["product_id"])
            ?? Self.trimmedString(data?["package_id"])
            ?? ""
        let packageID = Self.trimmedString(data?["package_id"])
            ?? Self.trimmedString(payload["package_id"])
            ?? productID
        let userID = Self.trimmedString(payload["user_id"])
            ?? Self.trimmedString(data?["user_id"])
            ?? ""

        guard !productID.isEmpty else {
            sendPurchaseFailure(requestID: requestID, packageID: packageID, message: "Product identifier is missing.")
            return
        }

        guard Self.approvedProductIDs.contains(productID) else {
            sendPurchaseFailure(requestID: requestID, packageID: packageID, message: "This product is not configured for Havra.")
            return
        }

        do {
            guard let product = try await Product.products(for: [productID]).first else {
                sendPurchaseFailure(requestID: requestID, packageID: packageID, message: "This product is unavailable from the App Store.")
                return
            }

            switch try await product.purchase() {
            case .success(let result):
                let transaction = try Self.verifiedTransaction(from: result)
                guard transaction.productID == productID else {
                    throw HavraPurchaseError.productMismatch
                }

                await transaction.finish()
                let coinPackage = Self.coinPackage(for: productID)
                sendPurchaseResult([
                    "status": "success",
                    "request_id": requestID,
                    "product_id": productID,
                    "package_id": packageID,
                    "coin_count": coinPackage?["coin_count"] ?? 0,
                    "transaction_id": String(transaction.id),
                    "user_id": userID,
                    "allow_transaction_fallback": true
                ])
            case .pending:
                sendPurchaseFailure(requestID: requestID, packageID: packageID, message: "The App Store purchase is pending approval.")
            case .userCancelled:
                sendPurchaseFailure(requestID: requestID, packageID: packageID, message: "The purchase was cancelled.")
            @unknown default:
                sendPurchaseFailure(requestID: requestID, packageID: packageID, message: "The App Store returned an unknown purchase state.")
            }
        } catch {
            sendPurchaseFailure(requestID: requestID, packageID: packageID, message: Self.purchaseMessage(for: error))
        }
    }

    @MainActor
    private func restoreCoinPackages(requestID: String) async {
        var restored: [[String: Any]] = []

        for await result in Transaction.currentEntitlements {
            guard case .verified(let transaction) = result,
                  Self.approvedProductIDs.contains(transaction.productID) else {
                continue
            }

            let coinPackage = Self.coinPackage(for: transaction.productID)
            restored.append([
                "status": "success",
                "request_id": requestID,
                "product_id": transaction.productID,
                "package_id": transaction.productID,
                "coin_count": coinPackage?["coin_count"] ?? 0,
                "transaction_id": String(transaction.id),
                "allow_transaction_fallback": true
            ])
        }

        sendPurchaseResult([
            "status": "success",
            "request_id": requestID,
            "purchases": restored,
            "restored_purchases": restored
        ])
    }

    private func sendPurchaseFailure(requestID: String, packageID: String, message: String) {
        sendPurchaseResult([
            "status": "failed",
            "request_id": requestID,
            "package_id": packageID,
            "message": message,
            "error_message": message
        ])
    }

    private func sendPurchaseResult(_ payload: [String: Any]) {
        guard JSONSerialization.isValidJSONObject(payload),
              let data = try? JSONSerialization.data(withJSONObject: payload),
              let json = String(data: data, encoding: .utf8) else {
            return
        }

        let script = """
        (function() {
          var result = \(json);
          if (window.PoetryIAP && typeof window.PoetryIAP.receive === 'function') {
            window.PoetryIAP.receive(result);
          }
          window.dispatchEvent(new CustomEvent('poetry-iap-result', { detail: result }));
        })();
        """
        communityWebView.evaluateJavaScript(script)
    }

    private static func verifiedTransaction<T>(from result: VerificationResult<T>) throws -> T {
        switch result {
        case .verified(let transaction):
            return transaction
        case .unverified:
            throw HavraPurchaseError.unverifiedTransaction
        }
    }

    private static func trimmedString(_ value: Any?) -> String? {
        guard let text = value as? String else { return nil }
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? nil : trimmed
    }

    private static func purchaseMessage(for error: Error) -> String {
        if error is HavraPurchaseError {
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

    private static let runtimeBundleURL: URL? = {
        Bundle.main.url(forResource: "HavraWebRuntime", withExtension: "bundle")
    }()

    private static func runtimeResourceURL(_ relativePath: String) -> URL? {
        runtimeBundleURL?.appendingPathComponent(relativePath)
    }

    private static let coinCatalog: [[String: Any]] = {
        guard let url = runtimeResourceURL(coinCatalogRelativePath),
        let data = try? Data(contentsOf: url),
        let root = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
        let packages = root["coin_packages"] as? [[String: Any]] else {
            return []
        }

        return packages
    }()

    private static let approvedProductIDs: Set<String> = {
        Set(coinCatalog.compactMap { package in
            trimmedString(package["product_id"]) ?? trimmedString(package["package_id"])
        })
    }()

    private static func coinPackage(for productID: String) -> [String: Any]? {
        coinCatalog.first { package in
            trimmedString(package["product_id"]) == productID || trimmedString(package["package_id"]) == productID
        }
    }

    private static let coinCatalogFetchScript: WKUserScript = {
        guard let url = runtimeResourceURL(coinCatalogRelativePath),
        let data = try? Data(contentsOf: url),
        let json = String(data: data, encoding: .utf8) else {
            return WKUserScript(source: "", injectionTime: .atDocumentStart, forMainFrameOnly: true)
        }

        return WKUserScript(
            source: """
            (function() {
              var havraCoinCatalog = \(json);
              var originalFetch = window.fetch ? window.fetch.bind(window) : null;
              window.fetch = function(resource, options) {
                var address = typeof resource === 'string'
                  ? resource
                  : (resource && resource.url ? resource.url : '');

                if (address.indexOf('\(coinCatalogRelativePath)') !== -1) {
                  return Promise.resolve(new Response(
                    JSON.stringify(havraCoinCatalog),
                    {
                      status: 200,
                      headers: { 'Content-Type': 'application/json' }
                    }
                  ));
                }

                if (originalFetch) return originalFetch(resource, options);
                return Promise.reject(new Error('Fetch is unavailable.'));
              };
            })();
            """,
            injectionTime: .atDocumentStart,
            forMainFrameOnly: true
        )
    }()

    private enum HavraPurchaseError: Error {
        case productMismatch
        case unverifiedTransaction
    }
}

private final class HavraRuntimeSchemeHandler: NSObject, WKURLSchemeHandler {
    private let runtimeRootURL: URL?

    init(runtimeRootURL: URL? = Bundle.main.url(forResource: "HavraWebRuntime", withExtension: "bundle")) {
        self.runtimeRootURL = runtimeRootURL
        super.init()
    }

    func webView(_ webView: WKWebView, start urlSchemeTask: WKURLSchemeTask) {
        guard let requestURL = urlSchemeTask.request.url,
              let rootURL = runtimeRootURL,
              let fileURL = Self.fileURL(for: requestURL, rootURL: rootURL) else {
            urlSchemeTask.didFailWithError(HavraRuntimeSchemeError.resourceUnavailable)
            return
        }

        do {
            let data = try Data(contentsOf: fileURL)
            let response = URLResponse(
                url: requestURL,
                mimeType: Self.mimeType(for: fileURL.pathExtension),
                expectedContentLength: data.count,
                textEncodingName: Self.textEncodingName(for: fileURL.pathExtension)
            )
            urlSchemeTask.didReceive(response)
            urlSchemeTask.didReceive(data)
            urlSchemeTask.didFinish()
        } catch {
            urlSchemeTask.didFailWithError(error)
        }
    }

    func webView(_ webView: WKWebView, stop urlSchemeTask: WKURLSchemeTask) {}

    private static func fileURL(for requestURL: URL, rootURL: URL) -> URL? {
        var relativePath = requestURL.path.removingPercentEncoding ?? requestURL.path
        if relativePath.isEmpty || relativePath == "/" {
            relativePath = "/index.html"
        }

        relativePath = relativePath.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        guard !relativePath.isEmpty,
              !relativePath.contains(".."),
              !relativePath.hasPrefix("~") else {
            return nil
        }

        return rootURL.appendingPathComponent(relativePath)
    }

    private static func mimeType(for pathExtension: String) -> String {
        switch pathExtension.lowercased() {
        case "html":
            return "text/html"
        case "js", "mjs":
            return "application/javascript"
        case "css":
            return "text/css"
        case "json":
            return "application/json"
        case "png":
            return "image/png"
        case "jpg", "jpeg":
            return "image/jpeg"
        case "gif":
            return "image/gif"
        case "svg":
            return "image/svg+xml"
        case "webp":
            return "image/webp"
        case "mp4":
            return "video/mp4"
        case "woff":
            return "font/woff"
        case "woff2":
            return "font/woff2"
        case "ttf":
            return "font/ttf"
        default:
            return "application/octet-stream"
        }
    }

    private static func textEncodingName(for pathExtension: String) -> String? {
        switch pathExtension.lowercased() {
        case "html", "js", "mjs", "css", "json", "svg":
            return "utf-8"
        default:
            return nil
        }
    }
}

private final class HavraWebScriptRelay: NSObject, WKScriptMessageHandler {
    weak var recipient: WKScriptMessageHandler?

    init(recipient: WKScriptMessageHandler) {
        self.recipient = recipient
        super.init()
    }

    func userContentController(
        _ userContentController: WKUserContentController,
        didReceive message: WKScriptMessage
    ) {
        recipient?.userContentController(userContentController, didReceive: message)
    }
}

private enum HavraRuntimeSchemeError: Error {
    case resourceUnavailable
}
