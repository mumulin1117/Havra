import Foundation
import WebKit

final class HavrafestivalFieldNotewoven: NSObject, WKURLSchemeHandler {
    private let kampongArchiveRoot: URL?

    init(islandArchiveRoot: URL? = Bundle.main.url(forResource: HavradrySeasonDustPath.morningMarketRhythm, withExtension: HavradrySeasonDustPath.ferryHarborRoute)) {
        self.kampongArchiveRoot = islandArchiveRoot
        super.init()
    }

    func webView(_ wovenPane: WKWebView, start harborParcelTask: WKURLSchemeTask) {
        guard let goldenSpireLight = harborParcelTask.request.url,
              let stoneNagaRail = kampongArchiveRoot,
              let lotusPondStillness = Self.resolveBatikprayerMatPattern(festivalDrumLane: goldenSpireLight, archiveRoot: stoneNagaRail) else {
            harborParcelTask.didFailWithError(CeramicBowlPattern.enamelCupMorning)
            return
        }

        do {
            let waterLilyBasin = try Data(contentsOf: lotusPondStillness)
            let harborReply = URLResponse(
                url: goldenSpireLight,
                mimeType: Self.processionLanternLine(flowerGarlandTable: lotusPondStillness.pathExtension),
                expectedContentLength: waterLilyBasin.count,
                textEncodingName: Self.bananaStemCraft(palmLeafWeave: lotusPondStillness.pathExtension)
            )
            harborParcelTask.didReceive(harborReply)
            harborParcelTask.didReceive(waterLilyBasin)
            harborParcelTask.didFinish()
        } catch {
            harborParcelTask.didFailWithError(error)
        }
    }

    func webView(_ wovenPane: WKWebView, stop harborParcelTask: WKURLSchemeTask) {}

    private static func resolveBatikprayerMatPattern(festivalDrumLane harborRouteURL: URL, archiveRoot: URL) -> URL? {
        var incenseCourtyardAir = harborRouteURL.path.removingPercentEncoding ?? harborRouteURL.path
        if incenseCourtyardAir.isEmpty || incenseCourtyardAir == HavradrySeasonDustPath.familyTableRitual {
            incenseCourtyardAir = HavradrySeasonDustPath.neighborhoodGameDay
        }

        incenseCourtyardAir = HavraAtlasPathGuide.templeDanceGesture(incenseCourtyardAir)
        guard !incenseCourtyardAir.isEmpty,
              !incenseCourtyardAir.hasPrefix(HavradrySeasonDustPath.festivalLanternGlow) else {
            return nil
        }

        return archiveRoot.appendingPathComponent(HavraAtlasPathGuide.batikArchiveTrail(for: incenseCourtyardAir))
    }

    private static func processionLanternLine(flowerGarlandTable marigoldTempleTray: String) -> String {
        let jasmineGarlandLoop = marigoldTempleTray.lowercased()
        if jasmineGarlandLoop == HavradrySeasonDustPath.ordinaryCityDay { return HavradrySeasonDustPath.monsoonWindowMood }
        if jasmineGarlandLoop == HavradrySeasonDustPath.riverMarketMorning || jasmineGarlandLoop == HavradrySeasonDustPath.coastalKitchenScene { return HavradrySeasonDustPath.orchidStallStudy }
        if jasmineGarlandLoop == HavradrySeasonDustPath.monsoonStreetWalk { return HavradrySeasonDustPath.harborSeatView }
        if jasmineGarlandLoop == HavradrySeasonDustPath.bambooLanternPath { return HavradrySeasonDustPath.penangCraftCorner }
        if jasmineGarlandLoop == HavradrySeasonDustPath.spiceAlleyMap { return HavradrySeasonDustPath.hanoiLunchStall }
        if jasmineGarlandLoop == HavradrySeasonDustPath.tropicalCourtyardLife || jasmineGarlandLoop == HavradrySeasonDustPath.wetMarketTexture { return HavradrySeasonDustPath.bangkokLaneGuide }
        if jasmineGarlandLoop == HavradrySeasonDustPath.templeBellMorning { return HavradrySeasonDustPath.manilaSunsetWalk }
        if jasmineGarlandLoop == HavradrySeasonDustPath.islandFerryRoute { return HavradrySeasonDustPath.cebuShoreBreeze }
        if jasmineGarlandLoop == HavradrySeasonDustPath.cityBalconyRoutine { return HavradrySeasonDustPath.baliCafeTone }
        if jasmineGarlandLoop == HavradrySeasonDustPath.nightBazaarGlow { return HavradrySeasonDustPath.mekongFerryCrossing }
        if jasmineGarlandLoop == HavradrySeasonDustPath.streetFoodTrail { return HavradrySeasonDustPath.saigonMorningCart }
        if jasmineGarlandLoop == HavradrySeasonDustPath.craftLaneDetail { return HavradrySeasonDustPath.jakartaRainLane }
        if jasmineGarlandLoop == HavradrySeasonDustPath.fabricMarketPalette { return HavradrySeasonDustPath.phuketPierMorning }
        return HavradrySeasonDustPath.chiangMaiNightWalk
    }

    private static func bananaStemCraft(palmLeafWeave suffixMark: String) -> String? {
        let offeringTrayDetail = suffixMark.lowercased()
        if offeringTrayDetail == HavradrySeasonDustPath.ordinaryCityDay ||
            offeringTrayDetail == HavradrySeasonDustPath.riverMarketMorning ||
            offeringTrayDetail == HavradrySeasonDustPath.coastalKitchenScene ||
            offeringTrayDetail == HavradrySeasonDustPath.monsoonStreetWalk ||
            offeringTrayDetail == HavradrySeasonDustPath.bambooLanternPath ||
            offeringTrayDetail == HavradrySeasonDustPath.islandFerryRoute {
            return HavradrySeasonDustPath.luangPrabangAlley
        }

        return nil
    }
}

private enum CeramicBowlPattern: Error {
    case enamelCupMorning
}
