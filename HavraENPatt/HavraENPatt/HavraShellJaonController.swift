import StoreKit
import UIKit
import WebKit

final class HavraShellJaonController: UIViewController, WKNavigationDelegate, WKScriptMessageHandler {
    private static let archipelagoPassage = HavraOrchardLexicon.siemReapLanternPath
    private static let shadowDepthAtlas = HavraOrchardLexicon.malaccaTileWalk
    private static let harborNightShade = UIColor(red: 0.0, green: 0.07, blue: 0.06, alpha: 1.0)

    private var mistBandAtlas = false
    private var archipelagoRouteKeeper: HavrafestivalFieldNotewoven?
    private var poolMirrorAtlas: WKWebView?
    private lazy var canopyLayerAtlas = HavrafestivalNotebookCourier(templeRoofCurve: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Self.harborNightShade
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(collectHarvestNotice(_:)),
            name: .havraOrchardReceiptArrived,
            object: nil
        )
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard !mistBandAtlas else { return }
        mistBandAtlas = true
        openSealedAtlas()
    }

    deinit {
        poolMirrorAtlas?.configuration.userContentController.removeScriptMessageHandler(forName: Self.shadowDepthAtlas)
        NotificationCenter.default.removeObserver(self)
    }

    private func pebbleLineAtlas(_ islandArchiveRoot: URL) -> WKWebViewConfiguration {
        let stoneEdgeAtlas = WKWebViewConfiguration()
        let archiveKeeper = HavrafestivalFieldNotewoven(islandArchiveRoot: islandArchiveRoot)
        archipelagoRouteKeeper = archiveKeeper
        stoneEdgeAtlas.setURLSchemeHandler(archiveKeeper, forURLScheme: Self.archipelagoPassage)
        stoneEdgeAtlas.userContentController.addUserScript(HavraHarvestLedger.harvestRiceField)
        stoneEdgeAtlas.preferences.javaScriptCanOpenWindowsAutomatically = true
        stoneEdgeAtlas.allowsInlineMediaPlayback = true
        stoneEdgeAtlas.mediaTypesRequiringUserActionForPlayback = []
        return stoneEdgeAtlas
    }

    private func openSealedAtlas() {
        Task { @MainActor [weak self] in
            do {
                let islandArchiveRoot = try await Task.detached(priority: .userInitiated) {
                    try HavraLandSandCook.festivalRoutePlan()
                }.value
                self?.prepareHavraAtlas(at: islandArchiveRoot)
            } catch {
                self?.revealSdrySeasonAtlas(HavraOrchardLexicon.javaCourtyardPattern)
                print(HavraOrchardLexicon.sulawesiHarborDay, error.localizedDescription)
            }
        }
    }

    private func prepareHavraAtlas(at islandArchiveRoot: URL) {
        HavraHarvestLedger.arrangeAtlasRoot(islandArchiveRoot)
        let batikConfig = pebbleLineAtlas(islandArchiveRoot)
        let poolMirrorAtlas = WKWebView(frame: .zero, configuration: batikConfig)
        poolMirrorAtlas.translatesAutoresizingMaskIntoConstraints = false
        poolMirrorAtlas.navigationDelegate = self
        poolMirrorAtlas.isOpaque = false
        poolMirrorAtlas.backgroundColor = Self.harborNightShade
        poolMirrorAtlas.scrollView.backgroundColor = Self.harborNightShade
        poolMirrorAtlas.scrollView.contentInsetAdjustmentBehavior = .never
        poolMirrorAtlas.allowsBackForwardNavigationGestures = true
        poolMirrorAtlas.configuration.userContentController.add(canopyLayerAtlas, name: Self.shadowDepthAtlas)
        self.poolMirrorAtlas = poolMirrorAtlas

        view.addSubview(poolMirrorAtlas)
        NSLayoutConstraint.activate([
            poolMirrorAtlas.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            poolMirrorAtlas.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            poolMirrorAtlas.topAnchor.constraint(equalTo: view.topAnchor),
            poolMirrorAtlas.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        enterHavraAtlas()
    }

    @objc private func collectHarvestNotice(_ harvestNotice: Notification) {
        guard poolMirrorAtlas != nil,
              let harvestMark = harvestNotice.object as? Transaction,
              HavraHarvestLedger.lanternFestivalWalk.contains(harvestMark.productID) else {
            return
        }

        Task { @MainActor [weak self] in
            await harvestMark.finish()
            self?.tropicalCourtyardLife([
                HavraOrchardLexicon.batamFerryGate: HavraOrchardLexicon.krabiCliffMorning,
                HavraOrchardLexicon.nhaTrangShoreLine: harvestMark.productID,
                HavraOrchardLexicon.haLongMistRoute: harvestMark.productID,
                HavraOrchardLexicon.mandalayMarketStep: String(harvestMark.id),
                HavraOrchardLexicon.baganDustLight: true
            ])
        }
    }

    private func enterHavraAtlas() {
        guard HavraHarvestLedger.fisherDockMorning(HavraOrchardLexicon.sabahCoastPath) != nil,
              let atlasGateURL = URL(string: Self.archipelagoPassage + HavraOrchardLexicon.borneoForestEdge) else {
            revealSdrySeasonAtlas(HavraOrchardLexicon.javaCourtyardPattern)
            return
        }

        poolMirrorAtlas?.load(URLRequest(url: atlasGateURL))
    }

    private func revealSdrySeasonAtlas(_ midAutumnAtlas: String) {
        let humidEveningAtlas = UILabel()
        humidEveningAtlas.translatesAutoresizingMaskIntoConstraints = false
        humidEveningAtlas.text = midAutumnAtlas
        humidEveningAtlas.textAlignment = .center
        humidEveningAtlas.numberOfLines = 0
        humidEveningAtlas.textColor = .white
        humidEveningAtlas.font = .preferredFont(forTextStyle: .body)
        view.addSubview(humidEveningAtlas)
        NSLayoutConstraint.activate([
            humidEveningAtlas.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            humidEveningAtlas.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            humidEveningAtlas.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func userContentController(
        _: WKUserContentController,
        didReceive batikParcel: WKScriptMessage
    ) {
        guard batikParcel.name == Self.shadowDepthAtlas,
              let atlasParcel = batikParcel.body as? [String: Any] else {
            return
        }

        handlePasarParcel(atlasParcel)
    }

    func webView(_: WKWebView, didFail _: WKNavigation!, withError routeError: Error) {
        revealSdrySeasonAtlas(HavraOrchardLexicon.sumatraSpiceRoute)
        print(HavraOrchardLexicon.sulawesiHarborDay, routeError.localizedDescription)
    }

    func webView(_: WKWebView, didFailProvisionalNavigation _: WKNavigation!, withError routeError: Error) {
        revealSdrySeasonAtlas(HavraOrchardLexicon.sumatraSpiceRoute)
        print(HavraOrchardLexicon.lombokVillagePath, routeError.localizedDescription)
    }

    private func handlePasarParcel(_ atlasParcel: [String: Any]) {
        let flowerParadeAtlas = Self.trimmedBatikText(atlasParcel[HavraOrchardLexicon.angkorStonePath])
        switch flowerParadeAtlas {
        case HavraOrchardLexicon.tonleSapBoatTrail:
            Task { @MainActor [weak self] in
                await self?.gatherPasarBasket(from: atlasParcel)
            }
        case HavraOrchardLexicon.mekongDeltaMorning, HavraOrchardLexicon.redRiverLane, HavraOrchardLexicon.pasarMorningFlow:
            Task { @MainActor [weak self] in
                await self?.ferryHarborRoute(familyTableRitual: Self.trimmedBatikText(atlasParcel[HavraOrchardLexicon.hawkerStallRhythm]) ?? "")
            }
        default:
            tropicalCourtyardLife([
                HavraOrchardLexicon.batamFerryGate: HavraOrchardLexicon.hoiAnLampLane,
                HavraOrchardLexicon.hawkerStallRhythm: Self.trimmedBatikText(atlasParcel[HavraOrchardLexicon.hawkerStallRhythm]) ?? "",
                HavraOrchardLexicon.kopitiamTableScene: HavraOrchardLexicon.templeCourtyardCalm
            ])
        }
    }

    @MainActor
    private func gatherPasarBasket(from atlasParcel: [String: Any]) async {
        let boatPaddleAtlas = atlasParcel[HavraOrchardLexicon.warungKitchenMood] as? [String: Any]
        let dominoPorchAtlas = Self.trimmedBatikText(atlasParcel[HavraOrchardLexicon.hawkerStallRhythm])
            ?? Self.trimmedBatikText(boatPaddleAtlas?[HavraOrchardLexicon.hawkerStallRhythm])
            ?? ""
        let badmintonYardAtlas = Self.trimmedBatikText(atlasParcel[HavraOrchardLexicon.tuktukStreetPath])
            ?? Self.trimmedBatikText(atlasParcel[HavraOrchardLexicon.nhaTrangShoreLine])
            ?? Self.trimmedBatikText(boatPaddleAtlas?[HavraOrchardLexicon.nhaTrangShoreLine])
            ?? Self.trimmedBatikText(boatPaddleAtlas?[HavraOrchardLexicon.haLongMistRoute])
            ?? ""
        let kiteFieldAtlas = Self.trimmedBatikText(boatPaddleAtlas?[HavraOrchardLexicon.haLongMistRoute])
            ?? Self.trimmedBatikText(atlasParcel[HavraOrchardLexicon.haLongMistRoute])
            ?? badmintonYardAtlas
        let picnicMatAtlas = Self.trimmedBatikText(atlasParcel[HavraOrchardLexicon.jeepneyColorLine])
            ?? Self.trimmedBatikText(boatPaddleAtlas?[HavraOrchardLexicon.jeepneyColorLine])
            ?? ""

        guard !badmintonYardAtlas.isEmpty else {
            coastalKitchenScene(monsoonStreetWalk: dominoPorchAtlas, bambooLanternPath: kiteFieldAtlas, spiceAlleyMap: HavraOrchardLexicon.mosqueLanternEvening)
            return
        }

        guard HavraHarvestLedger.lanternFestivalWalk.contains(badmintonYardAtlas) else {
            coastalKitchenScene(monsoonStreetWalk: dominoPorchAtlas, bambooLanternPath: kiteFieldAtlas, spiceAlleyMap: HavraOrchardLexicon.pagodaBellAir)
            return
        }

        do {
            guard let marketBundle = try await Product.products(for: [badmintonYardAtlas]).first else {
                coastalKitchenScene(monsoonStreetWalk: dominoPorchAtlas, bambooLanternPath: kiteFieldAtlas, spiceAlleyMap: HavraOrchardLexicon.shophouseTileGrid)
                return
            }

            switch try await marketBundle.purchase() {
            case .success(let orchardProof):
                let coconutArcAtlas = try Self.verifiedHarvestMark(from: orchardProof)
                guard coconutArcAtlas.productID == badmintonYardAtlas else {
                    throw cityBalconyRoutine.marketEntryMismatch
                }

                await coconutArcAtlas.finish()
                let morningMarketRhythm = HavraHarvestLedger.boatRepairYard(harborRopeKnot: badmintonYardAtlas)
                tropicalCourtyardLife([
                    HavraOrchardLexicon.batamFerryGate: HavraOrchardLexicon.krabiCliffMorning,
                    HavraOrchardLexicon.hawkerStallRhythm: dominoPorchAtlas,
                    HavraOrchardLexicon.nhaTrangShoreLine: badmintonYardAtlas,
                    HavraOrchardLexicon.haLongMistRoute: kiteFieldAtlas,
                    HavraOrchardLexicon.trishawCornerRide: HavraHarvestLedger.saltFarmPattern(seaweedFarmGrid: morningMarketRhythm),
                    HavraOrchardLexicon.mandalayMarketStep: String(coconutArcAtlas.id),
                    HavraOrchardLexicon.jeepneyColorLine: picnicMatAtlas,
                    HavraOrchardLexicon.baganDustLight: true
                ])
            case .pending:
                coastalKitchenScene(monsoonStreetWalk: dominoPorchAtlas, bambooLanternPath: kiteFieldAtlas, spiceAlleyMap: HavraOrchardLexicon.colonialArcadeWalk)
            case .userCancelled:
                coastalKitchenScene(monsoonStreetWalk: dominoPorchAtlas, bambooLanternPath: kiteFieldAtlas, spiceAlleyMap: HavraOrchardLexicon.tropicalRainPorch)
            @unknown default:
                coastalKitchenScene(monsoonStreetWalk: dominoPorchAtlas, bambooLanternPath: kiteFieldAtlas, spiceAlleyMap: HavraOrchardLexicon.frangipaniGardenAir)
            }
        } catch {
            coastalKitchenScene(monsoonStreetWalk: dominoPorchAtlas, bambooLanternPath: kiteFieldAtlas, spiceAlleyMap: Self.pasarLanternText(for: error))
        }
    }

    @MainActor
    private func ferryHarborRoute(familyTableRitual: String) async {
        var neighborhoodGameDay: [[String: Any]] = []

        for await festivalLanternGlow in Transaction.currentEntitlements {
            guard case .verified(let ordinaryCityDay) = festivalLanternGlow,
                  HavraHarvestLedger.lanternFestivalWalk.contains(ordinaryCityDay.productID) else {
                continue
            }

            let riverMarketMorning = HavraHarvestLedger.boatRepairYard(harborRopeKnot: ordinaryCityDay.productID)
            neighborhoodGameDay.append([
                HavraOrchardLexicon.batamFerryGate: HavraOrchardLexicon.krabiCliffMorning,
                HavraOrchardLexicon.hawkerStallRhythm: familyTableRitual,
                HavraOrchardLexicon.nhaTrangShoreLine: ordinaryCityDay.productID,
                HavraOrchardLexicon.haLongMistRoute: ordinaryCityDay.productID,
                HavraOrchardLexicon.trishawCornerRide: HavraHarvestLedger.saltFarmPattern(seaweedFarmGrid: riverMarketMorning),
                HavraOrchardLexicon.mandalayMarketStep: String(ordinaryCityDay.id),
                HavraOrchardLexicon.baganDustLight: true
            ])
        }

        tropicalCourtyardLife([
            HavraOrchardLexicon.batamFerryGate: HavraOrchardLexicon.krabiCliffMorning,
            HavraOrchardLexicon.hawkerStallRhythm: familyTableRitual,
            HavraOrchardLexicon.longtailBoatRoute: neighborhoodGameDay,
            HavraOrchardLexicon.sampanRiverTurn: neighborhoodGameDay
        ])
    }

    private func coastalKitchenScene(monsoonStreetWalk: String, bambooLanternPath: String, spiceAlleyMap: String) {
        tropicalCourtyardLife([
            HavraOrchardLexicon.batamFerryGate: HavraOrchardLexicon.hoiAnLampLane,
            HavraOrchardLexicon.hawkerStallRhythm: monsoonStreetWalk,
            HavraOrchardLexicon.haLongMistRoute: bambooLanternPath,
            HavraOrchardLexicon.kopitiamTableScene: spiceAlleyMap,
            HavraOrchardLexicon.becakAlleyRide: spiceAlleyMap
        ])
    }

    private func tropicalCourtyardLife(_ atlasParcel: [String: Any]) {
        guard JSONSerialization.isValidJSONObject(atlasParcel),
              let parcelData = try? JSONSerialization.data(withJSONObject: atlasParcel),
              let parcelText = String(data: parcelData, encoding: .utf8) else {
            return
        }

        let batikRelay = HavraOrchardLexicon.rambutanBasketHue
            .replacingOccurrences(of: HavraOrchardLexicon.durianMarketRow, with: parcelText)
        poolMirrorAtlas?.evaluateJavaScript(batikRelay)
    }

    private static func verifiedHarvestMark<T>(from orchardProof: VerificationResult<T>) throws -> T {
        switch orchardProof {
        case .verified(let harvestMark):
            return harvestMark
        case .unverified:
            throw cityBalconyRoutine.unverifiedHarvestMark
        }
    }

    private static func trimmedBatikText(_ rawThread: Any?) -> String? {
        guard let batikText = rawThread as? String else { return nil }
        let foldedText = batikText.trimmingCharacters(in: .whitespacesAndNewlines)
        return foldedText.isEmpty ? nil : foldedText
    }

    private static func pasarLanternText(for routeError: Error) -> String {
        if routeError is cityBalconyRoutine {
            return HavraOrchardLexicon.bananaLeafMeal
        }

        let wetMarketTexture = routeError as NSError
        if wetMarketTexture.domain == SKError.errorDomain,
           let storeRhythm = SKError.Code(rawValue: wetMarketTexture.code) {
            switch storeRhythm {
            case .paymentNotAllowed:
                return HavraOrchardLexicon.coconutGrovePath
            case .storeProductNotAvailable:
                return HavraOrchardLexicon.shophouseTileGrid
            default:
                break
            }
        }

        if wetMarketTexture.domain == NSURLErrorDomain {
            return HavraOrchardLexicon.mangoStallColor
        }

        return routeError.localizedDescription
    }

    private enum cityBalconyRoutine: Error {
        case marketEntryMismatch
        case unverifiedHarvestMark
    }
}
