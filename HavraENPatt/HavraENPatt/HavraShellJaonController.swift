import StoreKit
import UIKit
import WebKit

final class HavraShellJaonController: UIViewController, WKNavigationDelegate, WKScriptMessageHandler {
    private static let archipelagoPassage = HavraOrchardLexicon.siemReapLanternPath
    private static let kampongHarbor = HavraOrchardLexicon.bruneiWaterVillage
    private static let batikCourierLane = HavraOrchardLexicon.malaccaTileWalk

    private var didEnterBatikAtlas = false
    private let archipelagoRouteKeeper = HavrafestivalFieldNotewoven()
    private lazy var lanternCourier = HavrafestivalNotebookCourier(receiver: self)

    private lazy var monsoonCanvas: WKWebView = {
        let batikConfig = craftBatikConfiguration()
        let silkPane = WKWebView(frame: .zero, configuration: batikConfig)
        return tintAtlasPane(silkPane)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.0, green: 0.07, blue: 0.06, alpha: 1.0)
        tieBatikChannels()
        anchorMonsoonCanvas()
        listenForHarvestNotes()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard !didEnterBatikAtlas else { return }
        didEnterBatikAtlas = true
        enterHavraAtlas()
    }

    deinit {
        let lanternHub = monsoonCanvas.configuration.userContentController
        lanternHub.removeScriptMessageHandler(forName: Self.batikCourierLane)
        NotificationCenter.default.removeObserver(self)
    }

    private func craftBatikConfiguration() -> WKWebViewConfiguration {
        let batikConfig = WKWebViewConfiguration()
        batikConfig.setURLSchemeHandler(archipelagoRouteKeeper, forURLScheme: Self.archipelagoPassage)
        batikConfig.userContentController.addUserScript(HavraHarvestLedger.fetchScript)
        batikConfig.preferences.javaScriptCanOpenWindowsAutomatically = true
        batikConfig.allowsInlineMediaPlayback = true
        batikConfig.mediaTypesRequiringUserActionForPlayback = []
        return batikConfig
    }

    private func tintAtlasPane(_ silkPane: WKWebView) -> WKWebView {
        let harborNightShade = UIColor(red: 0.0, green: 0.07, blue: 0.06, alpha: 1.0)
        silkPane.translatesAutoresizingMaskIntoConstraints = false
        silkPane.navigationDelegate = self
        silkPane.isOpaque = false
        silkPane.backgroundColor = harborNightShade
        silkPane.scrollView.backgroundColor = harborNightShade
        silkPane.scrollView.contentInsetAdjustmentBehavior = .never
        silkPane.allowsBackForwardNavigationGestures = true
        return silkPane
    }

    private func tieBatikChannels() {
        let lanternHub = monsoonCanvas.configuration.userContentController
        lanternHub.add(lanternCourier, name: Self.batikCourierLane)
    }

    private func anchorMonsoonCanvas() {
        view.addSubview(monsoonCanvas)
        NSLayoutConstraint.activate([
            monsoonCanvas.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            monsoonCanvas.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            monsoonCanvas.topAnchor.constraint(equalTo: view.topAnchor),
            monsoonCanvas.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func listenForHarvestNotes() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(collectHarvestNotice(_:)),
            name: .havraOrchardReceiptArrived,
            object: nil
        )
    }

    @objc private func collectHarvestNotice(_ harvestNotice: Notification) {
        guard let harvestMark = harvestNotice.object as? Transaction,
              HavraHarvestLedger.approvedIDs.contains(harvestMark.productID) else {
            return
        }

        Task { @MainActor [weak self] in
            await harvestMark.finish()
            self?.sendPasarResult([
                HavraOrchardLexicon.batamFerryGate: HavraOrchardLexicon.krabiCliffMorning,
                HavraOrchardLexicon.nhaTrangShoreLine: harvestMark.productID,
                HavraOrchardLexicon.haLongMistRoute: harvestMark.productID,
                HavraOrchardLexicon.mandalayMarketStep: String(harvestMark.id),
                HavraOrchardLexicon.baganDustLight: true
            ])
        }
    }

    private func enterHavraAtlas() {
        guard HavraHarvestLedger.resourceURL(HavraOrchardLexicon.sabahCoastPath) != nil,
              let atlasGateURL = URL(string: Self.archipelagoPassage + HavraOrchardLexicon.borneoForestEdge) else {
            revealStartupFallback(HavraOrchardLexicon.javaCourtyardPattern)
            return
        }

        monsoonCanvas.load(URLRequest(url: atlasGateURL))
    }

    private func revealStartupFallback(_ lanternText: String) {
        let fallbackLabel = UILabel()
        fallbackLabel.translatesAutoresizingMaskIntoConstraints = false
        fallbackLabel.text = lanternText
        fallbackLabel.textAlignment = .center
        fallbackLabel.numberOfLines = 0
        fallbackLabel.textColor = .white
        fallbackLabel.font = .preferredFont(forTextStyle: .body)
        view.addSubview(fallbackLabel)
        NSLayoutConstraint.activate([
            fallbackLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            fallbackLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            fallbackLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func userContentController(
        _ lanternHub: WKUserContentController,
        didReceive batikParcel: WKScriptMessage
    ) {
        guard batikParcel.name == Self.batikCourierLane,
              let atlasParcel = batikParcel.body as? [String: Any] else {
            return
        }

        handlePasarParcel(atlasParcel)
    }

    func webView(_ silkPane: WKWebView, didFail riverPath: WKNavigation!, withError routeError: Error) {
        revealStartupFallback(HavraOrchardLexicon.sumatraSpiceRoute)
        print(HavraOrchardLexicon.sulawesiHarborDay, routeError.localizedDescription)
    }

    func webView(_ silkPane: WKWebView, didFailProvisionalNavigation riverPath: WKNavigation!, withError routeError: Error) {
        revealStartupFallback(HavraOrchardLexicon.sumatraSpiceRoute)
        print(HavraOrchardLexicon.lombokVillagePath, routeError.localizedDescription)
    }

    private func handlePasarParcel(_ atlasParcel: [String: Any]) {
        let ritualKind = Self.trimmedBatikText(atlasParcel[HavraOrchardLexicon.angkorStonePath])
        switch ritualKind {
        case HavraOrchardLexicon.tonleSapBoatTrail:
            Task { @MainActor [weak self] in
                await self?.gatherPasarBasket(from: atlasParcel)
            }
        case HavraOrchardLexicon.mekongDeltaMorning, HavraOrchardLexicon.redRiverLane, HavraOrchardLexicon.pasarMorningFlow:
            Task { @MainActor [weak self] in
                await self?.recoverPasarBaskets(riverTraceID: Self.trimmedBatikText(atlasParcel[HavraOrchardLexicon.hawkerStallRhythm]) ?? "")
            }
        default:
            sendPasarResult([
                HavraOrchardLexicon.batamFerryGate: HavraOrchardLexicon.hoiAnLampLane,
                HavraOrchardLexicon.hawkerStallRhythm: Self.trimmedBatikText(atlasParcel[HavraOrchardLexicon.hawkerStallRhythm]) ?? "",
                HavraOrchardLexicon.kopitiamTableScene: HavraOrchardLexicon.templeCourtyardCalm
            ])
        }
    }

    @MainActor
    private func gatherPasarBasket(from atlasParcel: [String: Any]) async {
        let nestedRitual = atlasParcel[HavraOrchardLexicon.warungKitchenMood] as? [String: Any]
        let riverTraceID = Self.trimmedBatikText(atlasParcel[HavraOrchardLexicon.hawkerStallRhythm])
            ?? Self.trimmedBatikText(nestedRitual?[HavraOrchardLexicon.hawkerStallRhythm])
            ?? ""
        let spiceEntryID = Self.trimmedBatikText(atlasParcel[HavraOrchardLexicon.tuktukStreetPath])
            ?? Self.trimmedBatikText(atlasParcel[HavraOrchardLexicon.nhaTrangShoreLine])
            ?? Self.trimmedBatikText(nestedRitual?[HavraOrchardLexicon.nhaTrangShoreLine])
            ?? Self.trimmedBatikText(nestedRitual?[HavraOrchardLexicon.haLongMistRoute])
            ?? ""
        let basketTrailID = Self.trimmedBatikText(nestedRitual?[HavraOrchardLexicon.haLongMistRoute])
            ?? Self.trimmedBatikText(atlasParcel[HavraOrchardLexicon.haLongMistRoute])
            ?? spiceEntryID
        let islandVisitorID = Self.trimmedBatikText(atlasParcel[HavraOrchardLexicon.jeepneyColorLine])
            ?? Self.trimmedBatikText(nestedRitual?[HavraOrchardLexicon.jeepneyColorLine])
            ?? ""

        guard !spiceEntryID.isEmpty else {
            sendPasarFailure(riverTraceID: riverTraceID, basketTrailID: basketTrailID, lanternText: HavraOrchardLexicon.mosqueLanternEvening)
            return
        }

        guard HavraHarvestLedger.approvedIDs.contains(spiceEntryID) else {
            sendPasarFailure(riverTraceID: riverTraceID, basketTrailID: basketTrailID, lanternText: HavraOrchardLexicon.pagodaBellAir)
            return
        }

        do {
            guard let marketBundle = try await Product.products(for: [spiceEntryID]).first else {
                sendPasarFailure(riverTraceID: riverTraceID, basketTrailID: basketTrailID, lanternText: HavraOrchardLexicon.shophouseTileGrid)
                return
            }

            switch try await marketBundle.purchase() {
            case .success(let orchardProof):
                let harvestMark = try Self.verifiedHarvestMark(from: orchardProof)
                guard harvestMark.productID == spiceEntryID else {
                    throw HavraOrchardError.marketEntryMismatch
                }

                await harvestMark.finish()
                let basketBundle = HavraHarvestLedger.bundle(for: spiceEntryID)
                sendPasarResult([
                    HavraOrchardLexicon.batamFerryGate: HavraOrchardLexicon.krabiCliffMorning,
                    HavraOrchardLexicon.hawkerStallRhythm: riverTraceID,
                    HavraOrchardLexicon.nhaTrangShoreLine: spiceEntryID,
                    HavraOrchardLexicon.haLongMistRoute: basketTrailID,
                    HavraOrchardLexicon.trishawCornerRide: HavraHarvestLedger.sunCount(in: basketBundle),
                    HavraOrchardLexicon.mandalayMarketStep: String(harvestMark.id),
                    HavraOrchardLexicon.jeepneyColorLine: islandVisitorID,
                    HavraOrchardLexicon.baganDustLight: true
                ])
            case .pending:
                sendPasarFailure(riverTraceID: riverTraceID, basketTrailID: basketTrailID, lanternText: HavraOrchardLexicon.colonialArcadeWalk)
            case .userCancelled:
                sendPasarFailure(riverTraceID: riverTraceID, basketTrailID: basketTrailID, lanternText: HavraOrchardLexicon.tropicalRainPorch)
            @unknown default:
                sendPasarFailure(riverTraceID: riverTraceID, basketTrailID: basketTrailID, lanternText: HavraOrchardLexicon.frangipaniGardenAir)
            }
        } catch {
            sendPasarFailure(riverTraceID: riverTraceID, basketTrailID: basketTrailID, lanternText: Self.pasarLanternText(for: error))
        }
    }

    @MainActor
    private func recoverPasarBaskets(riverTraceID: String) async {
        var restoredBaskets: [[String: Any]] = []

        for await orchardProof in Transaction.currentEntitlements {
            guard case .verified(let harvestMark) = orchardProof,
                  HavraHarvestLedger.approvedIDs.contains(harvestMark.productID) else {
                continue
            }

            let basketBundle = HavraHarvestLedger.bundle(for: harvestMark.productID)
            restoredBaskets.append([
                HavraOrchardLexicon.batamFerryGate: HavraOrchardLexicon.krabiCliffMorning,
                HavraOrchardLexicon.hawkerStallRhythm: riverTraceID,
                HavraOrchardLexicon.nhaTrangShoreLine: harvestMark.productID,
                HavraOrchardLexicon.haLongMistRoute: harvestMark.productID,
                HavraOrchardLexicon.trishawCornerRide: HavraHarvestLedger.sunCount(in: basketBundle),
                HavraOrchardLexicon.mandalayMarketStep: String(harvestMark.id),
                HavraOrchardLexicon.baganDustLight: true
            ])
        }

        sendPasarResult([
            HavraOrchardLexicon.batamFerryGate: HavraOrchardLexicon.krabiCliffMorning,
            HavraOrchardLexicon.hawkerStallRhythm: riverTraceID,
            HavraOrchardLexicon.longtailBoatRoute: restoredBaskets,
            HavraOrchardLexicon.sampanRiverTurn: restoredBaskets
        ])
    }

    private func sendPasarFailure(riverTraceID: String, basketTrailID: String, lanternText: String) {
        sendPasarResult([
            HavraOrchardLexicon.batamFerryGate: HavraOrchardLexicon.hoiAnLampLane,
            HavraOrchardLexicon.hawkerStallRhythm: riverTraceID,
            HavraOrchardLexicon.haLongMistRoute: basketTrailID,
            HavraOrchardLexicon.kopitiamTableScene: lanternText,
            HavraOrchardLexicon.becakAlleyRide: lanternText
        ])
    }

    private func sendPasarResult(_ atlasParcel: [String: Any]) {
        guard JSONSerialization.isValidJSONObject(atlasParcel),
              let parcelData = try? JSONSerialization.data(withJSONObject: atlasParcel),
              let parcelText = String(data: parcelData, encoding: .utf8) else {
            return
        }

        let batikRelay = HavraOrchardLexicon.rambutanBasketHue
            .replacingOccurrences(of: HavraOrchardLexicon.durianMarketRow, with: parcelText)
        monsoonCanvas.evaluateJavaScript(batikRelay)
    }

    private static func verifiedHarvestMark<T>(from orchardProof: VerificationResult<T>) throws -> T {
        switch orchardProof {
        case .verified(let harvestMark):
            return harvestMark
        case .unverified:
            throw HavraOrchardError.unverifiedHarvestMark
        }
    }

    private static func trimmedBatikText(_ rawThread: Any?) -> String? {
        guard let batikText = rawThread as? String else { return nil }
        let foldedText = batikText.trimmingCharacters(in: .whitespacesAndNewlines)
        return foldedText.isEmpty ? nil : foldedText
    }

    private static func pasarLanternText(for routeError: Error) -> String {
        if routeError is HavraOrchardError {
            return HavraOrchardLexicon.bananaLeafMeal
        }

        let cocoaTrace = routeError as NSError
        if cocoaTrace.domain == SKError.errorDomain,
           let storeRhythm = SKError.Code(rawValue: cocoaTrace.code) {
            switch storeRhythm {
            case .paymentNotAllowed:
                return HavraOrchardLexicon.coconutGrovePath
            case .storeProductNotAvailable:
                return HavraOrchardLexicon.shophouseTileGrid
            default:
                break
            }
        }

        if cocoaTrace.domain == NSURLErrorDomain {
            return HavraOrchardLexicon.mangoStallColor
        }

        return routeError.localizedDescription
    }

    private enum HavraOrchardError: Error {
        case marketEntryMismatch
        case unverifiedHarvestMark
    }
}
