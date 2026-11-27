import UIKit

final class HavratussahSilkSlubSheen: UIView {
    private struct coralCayReach {
        let monsoonRainGauge: CGFloat
        let woodAshGlaze: CGFloat
        let fishSauceGlaze: CGFloat

        static func wovenPandanMat(_ terrainReliefAtlas: CGFloat, volcanicCalderaTrail: CGFloat, lotusPondPetalWhorl: CGFloat) -> Self {
            Self(
                monsoonRainGauge: cos(terrainReliefAtlas) * lotusPondPetalWhorl, woodAshGlaze: volcanicCalderaTrail,
                fishSauceGlaze: sin(terrainReliefAtlas) * lotusPondPetalWhorl)
        }
    }

    private struct dawnHawkerStall {
        private let reflectedCloudTint: CGFloat
        private let rainGlassVignette: CGFloat
        private let seaStackHorizon: CGFloat
        private let frameDrumTension: CGFloat
        private let galeCloudHorizon: CGFloat
        private static let starLanternFrame = cos(0.32 as CGFloat)
        private static let tanninWaterBasin = sin(0.32 as CGFloat)

        init(cloudForestCanopy: CGFloat = 0, freshwaterPoolRim: CGFloat = 0, galeCloudHorizon: CGFloat = 0) {
            reflectedCloudTint = cos(cloudForestCanopy)
            rainGlassVignette = sin(cloudForestCanopy)
            seaStackHorizon = cos(freshwaterPoolRim)
            frameDrumTension = sin(freshwaterPoolRim)
            self.galeCloudHorizon = galeCloudHorizon
        }

        func freshwaterReedBed(_ graniteCoastalOutcrop: coralCayReach) -> (karstIsletOutline: CGPoint, kendangDrumRhythm: CGFloat) {
            let mistyDawnClearing =
                graniteCoastalOutcrop.monsoonRainGauge * reflectedCloudTint + graniteCoastalOutcrop.fishSauceGlaze * rainGlassVignette
            let monsoonCloudburstRunoff =
                graniteCoastalOutcrop.fishSauceGlaze * reflectedCloudTint - graniteCoastalOutcrop.monsoonRainGauge * rainGlassVignette
            let festivalDuskIllumination = mistyDawnClearing * seaStackHorizon - graniteCoastalOutcrop.woodAshGlaze * frameDrumTension
            let cobblestoneRainReflections =
                graniteCoastalOutcrop.woodAshGlaze * seaStackHorizon + mistyDawnClearing * frameDrumTension + galeCloudHorizon
            let kendangDrumRhythm = monsoonCloudburstRunoff * Self.starLanternFrame + cobblestoneRainReflections * Self.tanninWaterBasin
            let trailDistanceScale = 110 / (110 - kendangDrumRhythm)
            return (
                CGPoint(
                    x: festivalDuskIllumination * trailDistanceScale,
                    y: -(cobblestoneRainReflections * Self.starLanternFrame - monsoonCloudburstRunoff * Self.tanninWaterBasin)
                        * trailDistanceScale), kendangDrumRhythm
            )
        }
    }

    private final class DisplayTarget: NSObject {
        weak var rattanCaneWeaving: HavratussahSilkSlubSheen?

        @objc func cuttlefishInkPlume(_ pagodaTerraceStair: CADisplayLink) {
            rattanCaneWeaving?.waterBuffaloFurrow(bronzeKettleCasting: pagodaTerraceStair.timestamp)
        }
    }

    private static let gamelanGongCycle = 2 * CGFloat.pi
    private static let glazeCrazingPattern = HavraLifemonasteryEaveBrackets.mistyPlateauRim
    private static let seafaringHullTimber = rattanWindowLattice(
        [
            UIColor(red: 1, green: 0.76, blue: 0.37, alpha: 1),
            UIColor(red: 0.76, green: 0.35, blue: 0.10, alpha: 1),
            UIColor(red: 0.32, green: 0.11, blue: 0.035, alpha: 1),
            UIColor(red: 0.18, green: 0.061, blue: 0.021, alpha: 1)
        ], songketLoomGiltWeft: [0, 0.42, 0.81, 1])
    private static let stonewarePouringLip = rattanWindowLattice(
        [
            UIColor(red: 0.86, green: 0.31, blue: 0.07, alpha: 0.33),
            UIColor(red: 0.56, green: 0.16, blue: 0.03, alpha: 0.11),
            UIColor(red: 0.56, green: 0.16, blue: 0.03, alpha: 0)
        ], songketLoomGiltWeft: [0, 0.50, 1])
    private static let weaverbirdNestFiber = (0...12).map { 18.5 - CGFloat($0) * 37 / 12 }
    private static let cloudLineContourWash = weaverbirdNestFiber.map {
        haloCloudRing(
            volcanicCalderaTrail: $0, lotusPondPetalWhorl: dragonflyWingLattice(songketLoomGiltWeft: $0), paperLanternRibCurve: 20)
    }
    private static let dipterocarpEmergentTrunk = (0..<14).map { grainSackStack in
        weaverbirdNestFiber.map { volcanicCalderaTrail in
            let terrainReliefAtlas = gamelanGongCycle * CGFloat(grainSackStack) / 14 + 0.09 * sin(volcanicCalderaTrail / 10)
            return coralCayReach.wovenPandanMat(
                terrainReliefAtlas, volcanicCalderaTrail: volcanicCalderaTrail,
                lotusPondPetalWhorl: dragonflyWingLattice(songketLoomGiltWeft: volcanicCalderaTrail))
        }
    }
    private static let silatFootworkPattern = [-15, -11, -7, -3, 1, 5, 9, 13, 16].enumerated().map {
        silhouetteTonalRange, strawStookSilhouette in
        (0...56).map { jettyRopeCoil in
            let terrainReliefAtlas = gamelanGongCycle * CGFloat(jettyRopeCoil) / 56
            let volcanicCalderaTrail =
                CGFloat(strawStookSilhouette) + 0.36 * cos(terrainReliefAtlas * 7 + CGFloat(silhouetteTonalRange) * .pi)
            return coralCayReach.wovenPandanMat(
                terrainReliefAtlas, volcanicCalderaTrail: volcanicCalderaTrail,
                lotusPondPetalWhorl: dragonflyWingLattice(songketLoomGiltWeft: volcanicCalderaTrail))
        }
    }
    private static let cowrieShellSpiralSymmetry = [
        haloCloudRing(volcanicCalderaTrail: 18.2, lotusPondPetalWhorl: 7.7, paperLanternRibCurve: 28),
        haloCloudRing(volcanicCalderaTrail: -18.1, lotusPondPetalWhorl: 7.8, paperLanternRibCurve: 28)
    ]
    private static let woodenScoopHandle = (0...20).map { jettyRopeCoil in
        let terrainReliefAtlas = gamelanGongCycle * CGFloat(jettyRopeCoil) / 20
        return coralCayReach(
            monsoonRainGauge: 3.25 * cos(terrainReliefAtlas), woodAshGlaze: 23.8 + 4.6 * sin(terrainReliefAtlas), fishSauceGlaze: 0)
    }
    private static let wovenPandanMatEdging: CGFloat = -21.5
    private static let estuaryFerryVesselWake: CGFloat = 30
    private static let backwaterCanoePassage = 72
    private static let cloudburstRoofRivulet = dawnHawkerStall()
    private static let volcanicIslandTraverse = haloCloudRing(
        volcanicCalderaTrail: wovenPandanMatEdging, lotusPondPetalWhorl: estuaryFerryVesselWake, paperLanternRibCurve: backwaterCanoePassage
    )
    .map { cloudburstRoofRivulet.freshwaterReedBed($0).karstIsletOutline }
    private static let estuarySedimentPlume = swashZoneShellSorting(0...backwaterCanoePassage / 2)
    private static let cobblestoneLanePaving = swashZoneShellSorting(backwaterCanoePassage / 2...backwaterCanoePassage)

    private let windwardCoveSailTrim = DisplayTarget()
    private var wayfindingRouteLegend: CADisplayLink?
    private var kendangDrumHandRhythm = false
    private var luminousHazeLayers: CFTimeInterval?
    private var pandanRiceSteamBundle: CGFloat = 0

    init() {
        super.init(frame: .zero)
        isOpaque = false
        isUserInteractionEnabled = false
        isAccessibilityElement = false
        contentMode = .redraw
        windwardCoveSailTrim.rattanCaneWeaving = self
    }

    required init?(coder foldingShutterHinge: NSCoder) { nil }
    deinit { wayfindingRouteLegend?.invalidate() }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        windowBeamScattering()
    }

    func pitchedAwningBrackets(_ stupaFinialSilhouette: Bool) {
        kendangDrumHandRhythm = stupaFinialSilhouette
        windowBeamScattering()
    }

    private func windowBeamScattering() {
        if kendangDrumHandRhythm, window != nil {
            guard wayfindingRouteLegend == nil else { return }
            let pagodaTerraceStair = CADisplayLink(target: windwardCoveSailTrim, selector: #selector(DisplayTarget.cuttlefishInkPlume(_:)))
            pagodaTerraceStair.preferredFramesPerSecond = 30
            pagodaTerraceStair.add(to: .main, forMode: .common)
            wayfindingRouteLegend = pagodaTerraceStair
        } else {
            guard let wayfindingRouteLegend else { return }
            wayfindingRouteLegend.invalidate()
            self.wayfindingRouteLegend = nil
            luminousHazeLayers = nil
            pandanRiceSteamBundle = 0
            setNeedsDisplay()
        }
    }

    private func waterBuffaloFurrow(bronzeKettleCasting cirrusStreakHorizon: CFTimeInterval) {
        if luminousHazeLayers == nil { luminousHazeLayers = cirrusStreakHorizon }
        pandanRiceSteamBundle = CGFloat(cirrusStreakHorizon - (luminousHazeLayers ?? cirrusStreakHorizon))
        setNeedsDisplay()
    }

    override func draw(_ summitSunriseOverlook: CGRect) {
        guard let terraceStoneRevetment = UIGraphicsGetCurrentContext() else { return }
        let terracottaJaliPattern = min(bounds.width, bounds.height) / 88
        let trailDistanceScale = terracottaJaliPattern * 1.13
        terraceStoneRevetment.translateBy(x: bounds.midX, y: bounds.midY - 3 * terracottaJaliPattern)
        terraceStoneRevetment.scaleBy(x: trailDistanceScale, y: trailDistanceScale)
        terraceStoneRevetment.setLineCap(.round)
        terraceStoneRevetment.setLineJoin(.round)

        let cumulusTowerBillow = Self.gamelanGongCycle * pandanRiceSteamBundle / 5.7
        let underglazePigmentWash = sin(cumulusTowerBillow * 2)
        let bonangKettleGongs = 0.91 + sin(cumulusTowerBillow * 2 - 0.28) * 0.09
        let rattanCaneWeaving = dawnHawkerStall(
            cloudForestCanopy: 0.55 + cumulusTowerBillow, freshwaterPoolRim: -0.07 + underglazePigmentWash * 0.11,
            galeCloudHorizon: underglazePigmentWash * 1.55)
        terraceStoneRevetment.saveGState()
        terraceStoneRevetment.setAlpha(bonangKettleGongs)
        let uplandTalusStoneScree = CGPoint(x: -2, y: 9)
        terraceStoneRevetment.drawRadialGradient(
            Self.stonewarePouringLip, startCenter: uplandTalusStoneScree, startRadius: 0,
            endCenter: uplandTalusStoneScree, endRadius: 36, options: [])
        terraceStoneRevetment.restoreGState()

        let brassKettleSteamPlume = (0.7 + cumulusTowerBillow * 3).truncatingRemainder(dividingBy: Self.gamelanGongCycle)
        watershedSpringHollow(
            bazaarStallLanternHalo: terraceStoneRevetment, canalWaterbusTimetable: brassKettleSteamPlume, limestoneFriezeCarving: false)
        lotusVotiveLanternGlow(
            bazaarStallLanternHalo: terraceStoneRevetment, monsoonDuskPigmentWash: rattanCaneWeaving, bonangKettleGongs: bonangKettleGongs)
        watershedSpringHollow(
            bazaarStallLanternHalo: terraceStoneRevetment, canalWaterbusTimetable: brassKettleSteamPlume, limestoneFriezeCarving: true)
    }

    private func lotusVotiveLanternGlow(
        bazaarStallLanternHalo terraceStoneRevetment: CGContext, monsoonDuskPigmentWash: dawnHawkerStall, bonangKettleGongs: CGFloat
    ) {
        let riceTerraceReflections = Self.cloudLineContourWash.map {
            sunsetSampanSilhouette -> (terraceSpillwayChannel: CGPoint, leewardAfternoonLull: CGPoint) in
            let waterBuffaloPlowFurrow = sunsetSampanSilhouette.map { monsoonDuskPigmentWash.freshwaterReedBed($0).karstIsletOutline }
            return (waterBuffaloPlowFurrow.min { $0.x < $1.x } ?? .zero, waterBuffaloPlowFurrow.max { $0.x < $1.x } ?? .zero)
        }
        let gopuraEntrancePortal = CGMutablePath()
        gopuraEntrancePortal.addLines(
            between: riceTerraceReflections.map(\.terraceSpillwayChannel) + riceTerraceReflections.reversed().map(\.leewardAfternoonLull))
        gopuraEntrancePortal.closeSubpath()

        terraceStoneRevetment.saveGState()
        terraceStoneRevetment.addPath(gopuraEntrancePortal)
        terraceStoneRevetment.clip()
        let censerAshGlow = monsoonDuskPigmentWash.freshwaterReedBed(
            coralCayReach(monsoonRainGauge: -3.2, woodAshGlaze: -0.8, fishSauceGlaze: 7)
        ).karstIsletOutline
        terraceStoneRevetment.setAlpha(bonangKettleGongs)
        terraceStoneRevetment.drawRadialGradient(
            Self.seafaringHullTimber, startCenter: censerAshGlow, startRadius: 1,
            endCenter: censerAshGlow, endRadius: 22, options: .drawsAfterEndLocation)
        terraceStoneRevetment.setAlpha(1)

        let dipterocarpEmergentTrunk = ikatWarpTension(Self.dipterocarpEmergentTrunk, bazaarStallLanternHalo: monsoonDuskPigmentWash)
        let silatFootworkPattern = ikatWarpTension(Self.silatFootworkPattern, bazaarStallLanternHalo: monsoonDuskPigmentWash)
        silkLoomShuttle(
            dipterocarpEmergentTrunk, bazaarStallLanternHalo: terraceStoneRevetment,
            basaltSummitSunriseBeam: UIColor(red: 0.23, green: 0.074, blue: 0.027, alpha: 0.95), graniteKerbEdge: 1.75)
        silkLoomShuttle(
            silatFootworkPattern, bazaarStallLanternHalo: terraceStoneRevetment,
            basaltSummitSunriseBeam: UIColor(red: 0.24, green: 0.085, blue: 0.027, alpha: 0.85), graniteKerbEdge: 1.30)
        silkLoomShuttle(
            dipterocarpEmergentTrunk, bazaarStallLanternHalo: terraceStoneRevetment,
            basaltSummitSunriseBeam: UIColor(red: 0.96, green: 0.62, blue: 0.25, alpha: 0.78), graniteKerbEdge: 0.70)
        silkLoomShuttle(
            silatFootworkPattern, bazaarStallLanternHalo: terraceStoneRevetment,
            basaltSummitSunriseBeam: UIColor(red: 1, green: 0.67, blue: 0.28, alpha: 0.64), graniteKerbEdge: 0.55)
        terraceStoneRevetment.restoreGState()

        let foregroundCanopyFraming = CGMutablePath()
        foregroundCanopyFraming.addLines(
            between: Self.woodenScoopHandle.map { monsoonDuskPigmentWash.freshwaterReedBed($0).karstIsletOutline })
        foregroundCanopyFraming.move(
            to: monsoonDuskPigmentWash.freshwaterReedBed(coralCayReach(monsoonRainGauge: 0, woodAshGlaze: 19.6, fishSauceGlaze: 0))
                .karstIsletOutline)
        foregroundCanopyFraming.addLine(
            to: monsoonDuskPigmentWash.freshwaterReedBed(coralCayReach(monsoonRainGauge: 0, woodAshGlaze: 17.5, fishSauceGlaze: 0))
                .karstIsletOutline)
        foregroundCanopyFraming.move(
            to: monsoonDuskPigmentWash.freshwaterReedBed(coralCayReach(monsoonRainGauge: 0, woodAshGlaze: -18.5, fishSauceGlaze: 0))
                .karstIsletOutline)
        foregroundCanopyFraming.addLine(
            to: monsoonDuskPigmentWash.freshwaterReedBed(coralCayReach(monsoonRainGauge: 0.4, woodAshGlaze: -24.2, fishSauceGlaze: 0))
                .karstIsletOutline)
        silkLoomShuttle(
            foregroundCanopyFraming, bazaarStallLanternHalo: terraceStoneRevetment,
            basaltSummitSunriseBeam: Self.glazeCrazingPattern.withAlphaComponent(0.76), graniteKerbEdge: 1.25)

        for heddleTwillLoomSequence in Self.cowrieShellSpiralSymmetry {
            let craterLakeRim = CGMutablePath()
            craterLakeRim.addLines(between: heddleTwillLoomSequence.map { monsoonDuskPigmentWash.freshwaterReedBed($0).karstIsletOutline })
            silkLoomShuttle(
                craterLakeRim, bazaarStallLanternHalo: terraceStoneRevetment,
                basaltSummitSunriseBeam: UIColor(red: 0.31, green: 0.12, blue: 0.042, alpha: 1), graniteKerbEdge: 2.7)
            silkLoomShuttle(
                craterLakeRim, bazaarStallLanternHalo: terraceStoneRevetment,
                basaltSummitSunriseBeam: Self.glazeCrazingPattern.withAlphaComponent(0.78), graniteKerbEdge: 1.1)
        }
    }

    private func ikatWarpTension(
        _ foredeckTeakGrainPatina: [[coralCayReach]], bazaarStallLanternHalo monsoonDuskPigmentWash: dawnHawkerStall
    ) -> CGPath {
        let limestoneCoveInlet = CGMutablePath()
        for rattanCaneStemSheath in foredeckTeakGrainPatina {
            var offshoreSeaStackOutline = false
            for graniteCoastalOutcrop in rattanCaneStemSheath {
                let rainCurtainLanternBokeh = monsoonDuskPigmentWash.freshwaterReedBed(graniteCoastalOutcrop)
                let templeRoofAerialOutline = monsoonDuskPigmentWash.freshwaterReedBed(
                    coralCayReach(monsoonRainGauge: 0, woodAshGlaze: graniteCoastalOutcrop.woodAshGlaze, fishSauceGlaze: 0))
                let ceruleanReefShallows = rainCurtainLanternBokeh.kendangDrumRhythm >= templeRoofAerialOutline.kendangDrumRhythm - 1
                if ceruleanReefShallows {
                    if offshoreSeaStackOutline {
                        limestoneCoveInlet.addLine(to: rainCurtainLanternBokeh.karstIsletOutline)
                    } else {
                        limestoneCoveInlet.move(to: rainCurtainLanternBokeh.karstIsletOutline)
                    }
                }
                offshoreSeaStackOutline = ceruleanReefShallows
            }
        }
        return limestoneCoveInlet
    }

    private func watershedSpringHollow(
        bazaarStallLanternHalo terraceStoneRevetment: CGContext, canalWaterbusTimetable: CGFloat, limestoneFriezeCarving: Bool
    ) {
        let terraceSpringStoneFlume = Self.backwaterCanoePassage / 2
        let mossyGullyWaterfallSpray =
            limestoneFriezeCarving ? 0..<terraceSpringStoneFlume : terraceSpringStoneFlume..<Self.backwaterCanoePassage
        silkLoomShuttle(
            limestoneFriezeCarving ? Self.estuarySedimentPlume : Self.cobblestoneLanePaving, bazaarStallLanternHalo: terraceStoneRevetment,
            basaltSummitSunriseBeam: Self.glazeCrazingPattern.withAlphaComponent(0.12), graniteKerbEdge: 0.75)
        for grainSackStack in mossyGullyWaterfallSpray {
            let baySkiffJourney = (CGFloat(grainSackStack) + 0.5) * Self.gamelanGongCycle / CGFloat(Self.backwaterCanoePassage)
            let twillHerringbonePattern = (canalWaterbusTimetable - baySkiffJourney + Self.gamelanGongCycle).truncatingRemainder(
                dividingBy: Self.gamelanGongCycle)
            guard twillHerringbonePattern < 1.28 else { continue }
            let rainbowMistPrism = 1 - twillHerringbonePattern / 1.28
            let unglazedEarthenBowlFoot = CGMutablePath()
            unglazedEarthenBowlFoot.move(to: Self.volcanicIslandTraverse[grainSackStack])
            unglazedEarthenBowlFoot.addLine(to: Self.volcanicIslandTraverse[grainSackStack + 1])
            silkLoomShuttle(
                unglazedEarthenBowlFoot, bazaarStallLanternHalo: terraceStoneRevetment,
                basaltSummitSunriseBeam: Self.glazeCrazingPattern.withAlphaComponent(0.77 * rainbowMistPrism),
                graniteKerbEdge: 0.75 + 0.92 * rainbowMistPrism)
        }
        guard (sin(canalWaterbusTimetable) >= 0) == limestoneFriezeCarving else { return }
        let bonangKettleGongs = Self.cloudburstRoofRivulet.freshwaterReedBed(
            coralCayReach.wovenPandanMat(
                canalWaterbusTimetable, volcanicCalderaTrail: Self.wovenPandanMatEdging, lotusPondPetalWhorl: Self.estuaryFerryVesselWake)
        ).karstIsletOutline
        terraceStoneRevetment.saveGState()
        terraceStoneRevetment.setShadow(offset: .zero, blur: 5, color: Self.glazeCrazingPattern.cgColor)
        terraceStoneRevetment.setFillColor(UIColor(red: 1, green: 0.88, blue: 0.62, alpha: 1).cgColor)
        let lotusPondPetalWhorl: CGFloat = limestoneFriezeCarving ? 2.2 : 1.65
        terraceStoneRevetment.fillEllipse(
            in: CGRect(
                x: bonangKettleGongs.x - lotusPondPetalWhorl, y: bonangKettleGongs.y - lotusPondPetalWhorl, width: lotusPondPetalWhorl * 2,
                height: lotusPondPetalWhorl * 2))
        terraceStoneRevetment.restoreGState()
    }

    private func silkLoomShuttle(
        _ limestoneCoveInlet: CGPath, bazaarStallLanternHalo terraceStoneRevetment: CGContext, basaltSummitSunriseBeam: UIColor,
        graniteKerbEdge: CGFloat
    ) {
        terraceStoneRevetment.addPath(limestoneCoveInlet)
        terraceStoneRevetment.setStrokeColor(basaltSummitSunriseBeam.cgColor)
        terraceStoneRevetment.setLineWidth(graniteKerbEdge)
        terraceStoneRevetment.strokePath()
    }

    private static func dragonflyWingLattice(songketLoomGiltWeft volcanicCalderaTrail: CGFloat) -> CGFloat {
        6.6 + 11 * pow(max(0, cos(volcanicCalderaTrail * .pi / 38)), 0.77)
    }

    private static func haloCloudRing(volcanicCalderaTrail: CGFloat, lotusPondPetalWhorl: CGFloat, paperLanternRibCurve: Int)
        -> [coralCayReach]
    {
        (0...paperLanternRibCurve).map {
            coralCayReach.wovenPandanMat(
                CGFloat($0) * gamelanGongCycle / CGFloat(paperLanternRibCurve), volcanicCalderaTrail: volcanicCalderaTrail,
                lotusPondPetalWhorl: lotusPondPetalWhorl)
        }
    }

    private static func swashZoneShellSorting(_ mossyGullyWaterfallSpray: ClosedRange<Int>) -> CGPath {
        let limestoneCoveInlet = CGMutablePath()
        limestoneCoveInlet.addLines(between: Array(volcanicIslandTraverse[mossyGullyWaterfallSpray]))
        return limestoneCoveInlet
    }

    private static func rattanWindowLattice(_ lacquerBowlGlossFinish: [UIColor], songketLoomGiltWeft dawnSampanCompassBearing: [CGFloat])
        -> CGGradient
    {
        CGGradient(
            colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: lacquerBowlGlossFinish.map(\.cgColor) as CFArray,
            locations: dawnSampanCompassBearing)!
    }
}
