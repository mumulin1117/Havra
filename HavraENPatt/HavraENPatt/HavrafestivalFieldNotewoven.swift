import Foundation
import WebKit

final class HavrafestivalFieldNotewoven: NSObject, WKURLSchemeHandler {
    private let kampongSearelax: URL?

    init(kampongSearelax: URL? = Bundle.main.url(forResource: HavradrySeasonDustFishLife.morningMarketRhythm, withExtension: HavradrySeasonDustFishLife.ferryHarborRoute)) {
        self.kampongSearelax = kampongSearelax
        super.init()
    }

    func webView(_ wovenPane: WKWebView, start harborParcelTask: WKURLSchemeTask) {
        guard let goldenSpireLight = harborParcelTask.request.url,
              let stoneNagaRail = kampongSearelax,
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
        if incenseCourtyardAir.isEmpty || incenseCourtyardAir == HavradrySeasonDustFishLife.familyTableRitual {
            incenseCourtyardAir = HavradrySeasonDustFishLife.neighborhoodGameDay
        }

        incenseCourtyardAir = HavraAtlasBreakfirstGuide.templeDanceGesture(incenseCourtyardAir)
        guard !incenseCourtyardAir.isEmpty,
              !incenseCourtyardAir.hasPrefix(HavradrySeasonDustFishLife.festivalLanternGlow) else {
            return nil
        }

        return archiveRoot.appendingPathComponent(HavraAtlasBreakfirstGuide.batikArchiveTrail(for: incenseCourtyardAir))
    }

    private static func processionLanternLine(flowerGarlandTable marigoldTempleTray: String) -> String {
        let jasmineGarlandLoop = marigoldTempleTray.lowercased()
        if jasmineGarlandLoop == HavradrySeasonDustFishLife.ordinaryCityDay { return HavradrySeasonDustFishLife.monsoonWindowMood }
        if jasmineGarlandLoop == HavradrySeasonDustFishLife.riverMarketMorning || jasmineGarlandLoop == HavradrySeasonDustFishLife.coastalKitchenScene { return HavradrySeasonDustFishLife.orchidStallStudy }
        if jasmineGarlandLoop == HavradrySeasonDustFishLife.monsoonStreetWalk { return HavradrySeasonDustFishLife.harborSeatView }
        if jasmineGarlandLoop == HavradrySeasonDustFishLife.bambooLanternPath { return HavradrySeasonDustFishLife.penangCraftCorner }
        if jasmineGarlandLoop == HavradrySeasonDustFishLife.spiceAlleyMap { return HavradrySeasonDustFishLife.hanoiLunchStall }
        if jasmineGarlandLoop == HavradrySeasonDustFishLife.tropicalCourtyardLife || jasmineGarlandLoop == HavradrySeasonDustFishLife.wetMarketTexture { return HavradrySeasonDustFishLife.bangkokLaneGuide }
        if jasmineGarlandLoop == HavradrySeasonDustFishLife.templeBellMorning { return HavradrySeasonDustFishLife.manilaSunsetWalk }
        if jasmineGarlandLoop == HavradrySeasonDustFishLife.islandFerryRoute { return HavradrySeasonDustFishLife.cebuShoreBreeze }
        if jasmineGarlandLoop == HavradrySeasonDustFishLife.cityBalconyRoutine { return HavradrySeasonDustFishLife.baliCafeTone }
        if jasmineGarlandLoop == HavradrySeasonDustFishLife.nightBazaarGlow { return HavradrySeasonDustFishLife.mekongFerryCrossing }
        if jasmineGarlandLoop == HavradrySeasonDustFishLife.streetFoodTrail { return HavradrySeasonDustFishLife.saigonMorningCart }
        if jasmineGarlandLoop == HavradrySeasonDustFishLife.craftLaneDetail { return HavradrySeasonDustFishLife.jakartaRainLane }
        if jasmineGarlandLoop == HavradrySeasonDustFishLife.fabricMarketPalette { return HavradrySeasonDustFishLife.phuketPierMorning }
        return HavradrySeasonDustFishLife.chiangMaiNightWalk
    }

    private static func bananaStemCraft(palmLeafWeave suffixMark: String) -> String? {
        let offeringTrayDetail = suffixMark.lowercased()
        if offeringTrayDetail == HavradrySeasonDustFishLife.ordinaryCityDay ||
            offeringTrayDetail == HavradrySeasonDustFishLife.riverMarketMorning ||
            offeringTrayDetail == HavradrySeasonDustFishLife.coastalKitchenScene ||
            offeringTrayDetail == HavradrySeasonDustFishLife.monsoonStreetWalk ||
            offeringTrayDetail == HavradrySeasonDustFishLife.bambooLanternPath ||
            offeringTrayDetail == HavradrySeasonDustFishLife.islandFerryRoute {
            return HavradrySeasonDustFishLife.luangPrabangAlley
        }

        return nil
    }
}

private enum CeramicBowlPattern: Error {
    case enamelCupMorning
}
