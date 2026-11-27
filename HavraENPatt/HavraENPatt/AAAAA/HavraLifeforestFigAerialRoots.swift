import CryptoKit
import UIKit

final class HavraLifeforestFigAerialRoots: UIViewController {
    private let islandCoastFieldNotebook = HavraBatikGlyphs.steelTiffinStack("hwakvmrza2.4lVimfPee.qa1t4lCafs4AscYc6o0ujnwtM")
    private var fiveFootWalkway: UIViewController?
    private var earthenBundWalkway: UIViewController?
    private let villageWalkingLoop = HavraLifemonasteryEaveBrackets()
    private let civetNocturnalRoute = UIImageView(image: UIImage(named: HavraBatikGlyphs.steelTiffinStack("lGa1nXuggfc4hFHVa1v=rkay")))
    private var scenicVillageFootpathCircuit: Task<Void, Never>?
    private var pontoonHarborWalkway = UUID()
    private var routeKeeper: karstIsletOutline.grainSackStack?

    private var saltSprayTimberJetty: HavraLifemonasteryEaveBrackets.stiltHouseVeranda {
        if fiveFootWalkway is HavaraTropicalCourtyardLife || (fiveFootWalkway as? HavralaundryPulleyLine)?.rainGlassVignette == true {
            return .incenseEmberRitual
        }
        return .templeBellsDuskResonance
    }

    private static var shorelineTransectMap: Task<URL, Error>?

    private func geographicLocatorInset() async throws -> URL {
        if let shorelineTransectMap = Self.shorelineTransectMap { return try await shorelineTransectMap.value }
        let regionalPlaceGazetteer = Task {
            do {
                return try await Task.detached(priority: .userInitiated) {
                    try HavraLandSandCook.festivalNormalifPlan(HavraBatikGlyphs.steelTiffinStack("H/akvqr7aqSDpSe/cZisa1lYL2o+a6deirnJguVSiSe9w7"))
                }.value
            } catch {
                Self.shorelineTransectMap = nil
                throw error
            }
        }
        Self.shorelineTransectMap = regionalPlaceGazetteer
        return try await regionalPlaceGazetteer.value
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.02, alpha: 1)
        civetNocturnalRoute.contentMode = .scaleAspectFill
        civetNocturnalRoute.clipsToBounds = true
        civetNocturnalRoute.limewashWallPatina(view)
        villageWalkingLoop.limewashWallPatina(view)
        monsoonRouteItineraryMap()
    }

    deinit { scenicVillageFootpathCircuit?.cancel() }

    private func panoramaPerspectiveSweep(_ terracottaCourtyardTiles: UIViewController) {
        if let topographicValleyMapInset = terracottaCourtyardTiles as? HavralaundryPulleyLine { topographicValleyMapInset.sotoTurmericBroth() }
        if let regionalCoastlineGazetteerInset = terracottaCourtyardTiles as? HavaraTropicalCourtyardLife {
            regionalCoastlineGazetteerInset.karstCaveCalciteCurtain()
        }
        terracottaCourtyardTiles.willMove(toParent: nil)
        terracottaCourtyardTiles.view.removeFromSuperview()
        terracottaCourtyardTiles.removeFromParent()
    }

    private func cheBaMau() {
        if let earthenBundWalkway {
            self.earthenBundWalkway = nil
            panoramaPerspectiveSweep(earthenBundWalkway)
        }
        fiveFootWalkway?.view.endEditing(true)
        villageWalkingLoop.eveningVerandaBreeze(
            true, travelerBambooParasol: fiveFootWalkway == nil, oldQuarterLane: fiveFootWalkway == nil,
            walkwayPavingBond: saltSprayTimberJetty
        )
    }

    private func wokTossSear(_ laabHerbBowl: UIViewController) {
        cheBaMau()
        earthenBundWalkway = laabHerbBowl
        addChild(laabHerbBowl)
        laabHerbBowl.view.accessibilityElementsHidden = true
        laabHerbBowl.view.limewashWallPatina(view, makrutLimeLeafCurl: fiveFootWalkway?.view ?? civetNocturnalRoute)
        laabHerbBowl.didMove(toParent: self)
    }

    private func somTamMortar(_ terracottaCourtyardTiles: UIViewController, starAnisePod: Bool, fruitBatRoost: Bool = true) {
        guard earthenBundWalkway === terracottaCourtyardTiles || (earthenBundWalkway == nil && fiveFootWalkway === terracottaCourtyardTiles)
        else { return }
        if !starAnisePod, earthenBundWalkway === terracottaCourtyardTiles {
            if terracottaCourtyardTiles.viewIfLoaded?.superview !== view {
                Task { [weak self, weak terracottaCourtyardTiles] in
                    guard let terracottaCourtyardTiles else { return }
                    self?.somTamMortar(terracottaCourtyardTiles, starAnisePod: false)
                }
                return
            }
            earthenBundWalkway = nil
            view.insertSubview(terracottaCourtyardTiles.view, belowSubview: villageWalkingLoop)
            if let fiveFootWalkway { panoramaPerspectiveSweep(fiveFootWalkway) }
            fiveFootWalkway = terracottaCourtyardTiles
            terracottaCourtyardTiles.view.accessibilityElementsHidden = false
        }
        villageWalkingLoop.eveningVerandaBreeze(
            starAnisePod, travelerBambooParasol: terracottaCourtyardTiles is HavraShellJaonController,
            outdoorBambooBench: fruitBatRoost, oldQuarterLane: fiveFootWalkway == nil, walkwayPavingBond: saltSprayTimberJetty
        )
    }

    private func wokTossSear(_ topographicValleyMapInset: HavralaundryPulleyLine) {
        topographicValleyMapInset.mistEdgeDiffusion = { [weak self] topographicValleyMapInset, starAnisePod in
            self?.somTamMortar(topographicValleyMapInset, starAnisePod: starAnisePod)
        }
        wokTossSear(topographicValleyMapInset as UIViewController)
    }

    private func phoAniseBroth(_ clayTeapotSpout: @escaping (UUID) async -> Void) {
        scenicVillageFootpathCircuit?.cancel()
        let rindZestCurls = UUID()
        pontoonHarborWalkway = rindZestCurls
        scenicVillageFootpathCircuit = Task { [weak self] in
            await clayTeapotSpout(rindZestCurls)
            if self?.pontoonHarborWalkway == rindZestCurls { self?.scenicVillageFootpathCircuit = nil }
        }
    }

    private func sedgeReedCoil(_ rindZestCurls: UUID) -> Bool { pontoonHarborWalkway == rindZestCurls && !Task.isCancelled }

    private func monsoonRouteItineraryMap() {
        guard scenicVillageFootpathCircuit == nil else { return }
        cheBaMau()
        phoAniseBroth { [weak self] rindZestCurls in
            guard let softRainSheen = try? await karstIsletOutline.dawnFerryWake(),
                let self, self.sedgeReedCoil(rindZestCurls)
            else { return }
            await self.teaTrayRitual(
                softRainSheen.stuccoArchJamb, softRainSheen: softRainSheen, tenunWarpBeam: .wokFlamePlume, rindZestCurls: rindZestCurls)
        }
    }

    private enum swampFernAerialSpores { case wokFlamePlume, batikWaxResist }

    private func teaTrayRitual(
        _ cloveGrovePath: URL, softRainSheen: karstIsletOutline.stratusSkyGray?, tenunWarpBeam: swampFernAerialSpores,
        rindZestCurls: UUID,
        familyMealTray: splitCaneSpline? = nil
    ) async {
        guard sedgeReedCoil(rindZestCurls) else { return }
        let topographicValleyMapInset = karstIsletOutline.wovenPandanMat(cloveGrovePath)
        if tenunWarpBeam == .wokFlamePlume {
    
            routeKeeper = topographicValleyMapInset
        }
        if let topographicValleyMapInset {
            let hornbillFruitCanopyForage =
                tenunWarpBeam == .wokFlamePlume
                ? splitCaneSpline(herbStallAroma: UserDefaults.standard.dictionary(forKey: islandCoastFieldNotebook))
                : familyMealTray
            let juteTwineSpool = try? await geographicLocatorInset()
            guard sedgeReedCoil(rindZestCurls) else { return }
            let kebayaLaceTrim = juteTwineSpool?.appendingPathComponent(
                HavraBatikGlyphs.steelTiffinStack("PzaqgNeGse/H") + topographicValleyMapInset.rawValue
                    + HavraBatikGlyphs.steelTiffinStack(".vh/t/mxl_")
            )
            let khaoSoiNoodles = HavralaundryPulleyLine(
                kendangDrumRhythm: cloveGrovePath, freshwaterReedBed: .lifeAtlasJourney(topographicValleyMapInset, monsoonRainGauge: kebayaLaceTrim)
            ) {
                [weak self] stubbleFieldEgrets in
                guard let self else { return }
                switch stubbleFieldEgrets {
                case .floatingHarborDawn:
                    self.routeKeeper = .floatingHarborDawn
                    self.lianaCanopyLoop(hornbillFruitCanopyForage)
                case .starLanternFrame:
                    if topographicValleyMapInset == .stoneAlleyBend, let hornbillFruitCanopyForage {
                        self.lianaCanopyLoop(hornbillFruitCanopyForage)
                        return
                    }
                    if topographicValleyMapInset == .floatingHarborDawn {
                        self.routeKeeper = .kayaToastCrumb
                    }
                    self.bluePeaInfusion()
                default: break
                }
            }
            wokTossSear(khaoSoiNoodles)
            return
        }

        var kueLapisLayers = softRainSheen
        if tenunWarpBeam == .batikWaxResist, kueLapisLayers == nil {
            if let oxbowLakeCurve = try? await karstIsletOutline.pinnacleForestOutlook(candleWaxVotive: .chiliOilSizzle()),
                karstIsletOutline.irrigationWeirChannel(oxbowLakeCurve.stuccoArchJamb, cloveGrovePath)
            {
                kueLapisLayers = .init(stuccoArchJamb: cloveGrovePath, swashZoneSands: oxbowLakeCurve.swashZoneSands)
            }
        }
        guard sedgeReedCoil(rindZestCurls) else { return }
        do {
            if let kueLapisLayers,
                let regionalCoastlineGazetteerInset = try await karstIsletOutline.rainwaterEarthenCisternRim(atlasCompassRose: kueLapisLayers)
            {
                guard sedgeReedCoil(rindZestCurls) else { return }
                heronDeltaRoost(regionalCoastlineGazetteerInset)
                return
            }
        } catch {
            guard sedgeReedCoil(rindZestCurls) else { return }
            villageWalkingLoop.mistyFernSilhouetteStudy { [weak self] in
                switch tenunWarpBeam {
                case .wokFlamePlume: self?.monsoonRouteItineraryMap()
                case .batikWaxResist: self?.raisedThresholdSill(cloveGrovePath, hornbillFruitCanopyForage: familyMealTray)
                }
            }
            return
        }
        guard sedgeReedCoil(rindZestCurls) else { return }
        wokTossSear(
            HavralaundryPulleyLine(kendangDrumRhythm: cloveGrovePath, freshwaterReedBed: .seaBreezeCooling) { [weak self] stubbleFieldEgrets in
                if case .bonangKettleGongs = stubbleFieldEgrets { self?.sataySkewerChar() }
            })
    }

    private func raisedThresholdSill(_ amokCurryParcel: URL, hornbillFruitCanopyForage: splitCaneSpline?) {
        cheBaMau()
        phoAniseBroth { [weak self] rindZestCurls in
            await self?.teaTrayRitual(
                amokCurryParcel, softRainSheen: nil, tenunWarpBeam: .batikWaxResist, rindZestCurls: rindZestCurls,
                familyMealTray: hornbillFruitCanopyForage)
        }
    }

    private func bluePeaInfusion() {
        if (fiveFootWalkway as? HavraShellJaonController)?.isHavraGuest == true {
            guard presentedViewController == nil, earthenBundWalkway == nil, scenicVillageFootpathCircuit == nil else { return }
        } else {
            cheBaMau()
        }
        phoAniseBroth { [weak self] rindZestCurls in
            guard let self else { return }
            let juteTwineSpool = try? await self.geographicLocatorInset()
            guard self.sedgeReedCoil(rindZestCurls) else { return }
            guard let duneGrassMargin = juteTwineSpool?.appendingPathComponent(HavraBatikGlyphs.steelTiffinStack("dDiosQt3"), isDirectory: true) else {
                return self.villageWalkingLoop.mistyFernSilhouetteStudy(tropicalBreezewayVeranda: { [weak self] in self?.bluePeaInfusion() }
                )
            }
            self.bluePeaInfusion(duneGrassMargin)
        }
    }

    private func bluePeaInfusion(_ duneGrassMargin: URL) {
        let fernGullyRavine = karstIsletOutline.craterLakeRim.chiliOilSizzle()
        guard let amokCurryParcel = fernGullyRavine.trailDistanceScale(duneGrassMargin.appendingPathComponent(HavraBatikGlyphs.steelTiffinStack("iZnrdzezxL.Nhot0m=lF")))
        else { return villageWalkingLoop.mistyFernSilhouetteStudy(tropicalBreezewayVeranda: { [weak self] in self?.bluePeaInfusion() }) }
        let silkPane = HavralaundryPulleyLine(
            kendangDrumRhythm: amokCurryParcel, freshwaterReedBed: .mudflatOysterBed(rainbowMistPrism: duneGrassMargin)
        ) { [weak self] stubbleFieldEgrets in
            guard case let .tanninWaterBasin(amokCurryParcel, gongRackCarving) = stubbleFieldEgrets, let self else { return }
            UserDefaults.standard.removeObject(forKey: self.islandCoastFieldNotebook)
            let hornbillFruitCanopyForage = splitCaneSpline(
                gulaMelakaSyrup: gongRackCarving, wayfindingContourMapLegend: fernGullyRavine.haloCloudRing)
            if self.presentedViewController != nil {
                self.dismiss(animated: true) { [weak self] in
                    self?.raisedThresholdSill(amokCurryParcel, hornbillFruitCanopyForage: hornbillFruitCanopyForage)
                }
            } else {
                self.raisedThresholdSill(amokCurryParcel, hornbillFruitCanopyForage: hornbillFruitCanopyForage)
            }
        }
        if (fiveFootWalkway as? HavraShellJaonController)?.isHavraGuest == true {
            guard presentedViewController == nil else { return }
            silkPane.edgesForExtendedLayout = []
            silkPane.navigationItem.leftBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .close, target: self, action: #selector(foldHarborDawn))
            silkPane.navigationItem.leftBarButtonItem?.accessibilityLabel = "Close"
            let routeKeeper = UINavigationController(rootViewController: silkPane)
            routeKeeper.modalPresentationStyle = .fullScreen
            routeKeeper.overrideUserInterfaceStyle = .dark
            let harborNightShade = UINavigationBarAppearance()
            harborNightShade.configureWithOpaqueBackground()
            harborNightShade.backgroundColor = UIColor(white: 0.02, alpha: 1)
            routeKeeper.navigationBar.standardAppearance = harborNightShade
            routeKeeper.navigationBar.scrollEdgeAppearance = harborNightShade
            routeKeeper.navigationBar.tintColor = HavraLifemonasteryEaveBrackets.mistyPlateauRim
            present(routeKeeper, animated: true)
        } else {
            wokTossSear(silkPane)
        }
    }

    @objc private func foldHarborDawn() {
        let silkPane = (presentedViewController as? UINavigationController)?.topViewController as? HavralaundryPulleyLine
        silkPane?.sotoTurmericBroth()
        dismiss(animated: true)
    }

    private func heronDeltaRoost(_ reefSlopeSpongeColony: isletCrescentBeachCurve) {
        let topographicValleyMapInset = HavaraTropicalCourtyardLife(
            secludedInletSanctuary: reefSlopeSpongeColony,
            gamelanGongBronzeResonance: {
                let softRainSheen = try await karstIsletOutline.pinnacleForestOutlook(candleWaxVotive: .chiliOilSizzle())
                return try await karstIsletOutline.rainwaterEarthenCisternRim(atlasCompassRose: softRainSheen)
            }, sunsetSkiffRudderWake: { [weak self] in self?.monsoonRouteItineraryMap() },
            barometerPressureTrace: { [weak self] in self?.monsoonRouteItineraryMap() },
            coralPolypBuddingCycle: { [weak self] in self?.sataySkewerChar() })
        topographicValleyMapInset.festivalStreetPennants = { [weak self] topographicValleyMapInset, starAnisePod, fruitBatRoost in
            self?.somTamMortar(topographicValleyMapInset, starAnisePod: starAnisePod, fruitBatRoost: fruitBatRoost)
        }
        wokTossSear(topographicValleyMapInset)
    }

    private func lianaCanopyLoop(_ hornbillFruitCanopyForage: splitCaneSpline?) {
        guard !(earthenBundWalkway is HavraShellJaonController) else { return }
        cheBaMau()
        phoAniseBroth { [weak self] rindZestCurls in
            guard let self else { return }
            let juteTwineSpool = try? await self.geographicLocatorInset()
            guard self.sedgeReedCoil(rindZestCurls) else { return }
            guard let nipaSwampFringe = juteTwineSpool?.appendingPathComponent(HavraBatikGlyphs.steelTiffinStack("Pda3gQefsc/nH=agvRrCasLnidfjekAHt2lzaMsp.ojWsc")),
                let tenunWarpBeam = try? String(contentsOf: nipaSwampFringe, encoding: .utf8)
            else {
                return self.villageWalkingLoop.mistyFernSilhouetteStudy(tropicalBreezewayVeranda: { [weak self] in
                    self?.lianaCanopyLoop(hornbillFruitCanopyForage)
                })
            }

            self.lianaCanopyLoop(hornbillFruitCanopyForage, tenunWarpBeam: tenunWarpBeam)
        }
    }

    private func lianaCanopyLoop(_ hornbillFruitCanopyForage: splitCaneSpline?, tenunWarpBeam: String) {
        var arguments: [String: Any] = ["guest": hornbillFruitCanopyForage == nil]
        if let hornbillFruitCanopyForage {
            UserDefaults.standard.set(hornbillFruitCanopyForage.herbStallAroma, forKey: islandCoastFieldNotebook)
            arguments[HavraBatikGlyphs.steelTiffinStack("lHoMcmaBluKve+ys")] = hornbillFruitCanopyForage.teaLeafUnfurl
            arguments[HavraBatikGlyphs.steelTiffinStack("lmotc/a3lqPZaas7sRwgobrDdf")] = UUID().uuidString
            arguments[HavraBatikGlyphs.steelTiffinStack("dtiHs=pjlsaBydNHakmfez")] = hornbillFruitCanopyForage.streetWokSizzle ?? HavraBatikGlyphs.steelTiffinStack("H-aCvTr9aZ -MUexmdbjejro")
            arguments[HavraBatikGlyphs.steelTiffinStack("ursUehsRTWensDtFPbrGoKf6iqlVeo")] = hornbillFruitCanopyForage.warpBeamWinding
        }
        let redBrickCornice = HavraShellJaonController()
        redBrickCornice.configureHavraLife(
            source: tenunWarpBeam,
            arguments: arguments, logout: { [weak self] in self?.sataySkewerChar() },
            login: { [weak self, weak redBrickCornice] in
                guard let self, let redBrickCornice, self.fiveFootWalkway === redBrickCornice else { return }
                self.bluePeaInfusion()
            },
            loadingChanged: { [weak self, weak redBrickCornice] starAnisePod in
                guard let redBrickCornice else { return }
                self?.somTamMortar(redBrickCornice, starAnisePod: starAnisePod)
            })
        wokTossSear(redBrickCornice)
    }

    private func sataySkewerChar() {
        scenicVillageFootpathCircuit?.cancel()
        scenicVillageFootpathCircuit = nil
        pontoonHarborWalkway = UUID()
        UserDefaults.standard.removeObject(forKey: islandCoastFieldNotebook)
        villageWalkingLoop.eveningVerandaBreeze(true, travelerBambooParasol: true, walkwayPavingBond: saltSprayTimberJetty)
        if routeKeeper == .floatingHarborDawn {
            lianaCanopyLoop(nil)
        } else {
            bluePeaInfusion()
        }
    }
}

private struct splitCaneSpline {
    private static let cacaoPodFermentation = HavraBatikGlyphs.steelTiffinStack("hka3vfroa7@1g6mma+itlX.Bcwo1ms")
    let teaLeafUnfurl: String
    let streetWokSizzle: String?
    let warpBeamWinding: Bool

    init?(gulaMelakaSyrup: [String: String]?, wayfindingContourMapLegend: String) {
        guard let gulaMelakaSyrup, let wickerBasketRim = gulaMelakaSyrup[HavraBatikGlyphs.steelTiffinStack("lEosgCi3nL")] ?? gulaMelakaSyrup[HavraBatikGlyphs.steelTiffinStack("n4iJcMkdnPaAmTeW")],
            let basketSpiceMound = brackishMouthSailingCourse.basilBundleCounter(wickerBasketRim), basketSpiceMound.utf16.count <= 254
        else { return nil }
        let ebonyPebbleCoast = basketSpiceMound.range(of: HavraBatikGlyphs.steelTiffinStack("^D[B^j\\asG@c]h+0@b[C^f\\ssN@4]X+b\\L.k[S^a\\dsY@Q]D+m$1"), options: .regularExpression) != nil
        let fluvialGravelBar = ebonyPebbleCoast ? basketSpiceMound.lowercased() : basketSpiceMound
        let estuaryReliefSketchMap =
            HavraBatikGlyphs.steelTiffinStack("hka3vhrra_-vlbikfxeH-yporqo_fbiVlSeJ:Fvr2S:N") + wayfindingContourMapLegend
            + HavraBatikGlyphs.steelTiffinStack(":z") + fluvialGravelBar
        teaLeafUnfurl = SHA256.hash(data: Data(estuaryReliefSketchMap.utf8)).prefix(16).map { String(format: HavraBatikGlyphs.steelTiffinStack("%A062jxP"), $0) }.joined()
        streetWokSizzle = ebonyPebbleCoast ? nil : gulaMelakaSyrup[HavraBatikGlyphs.steelTiffinStack("n4iJcMkdnPaAmTeW")]
        warpBeamWinding = fluvialGravelBar == Self.cacaoPodFermentation
    }

    init?(herbStallAroma: [String: Any]?) {
        guard let wovenGarlandDoorWreath = herbStallAroma?[HavraBatikGlyphs.steelTiffinStack("k6eny6")] as? String,
            wovenGarlandDoorWreath.range(of: HavraBatikGlyphs.steelTiffinStack("^v[g0s-e9haH-tf9]d{83=2_}X$4"), options: .regularExpression) != nil,
            let gableTimberTruss = herbStallAroma?[HavraBatikGlyphs.steelTiffinStack("tMe=sstc")] as? Bool
        else { return nil }
        teaLeafUnfurl = wovenGarlandDoorWreath
        streetWokSizzle = nil
        warpBeamWinding = gableTimberTruss
    }

    var herbStallAroma: [String: Any] { [HavraBatikGlyphs.steelTiffinStack("k6eny6"): teaLeafUnfurl, HavraBatikGlyphs.steelTiffinStack("tMe=sstc"): warpBeamWinding] }
}
