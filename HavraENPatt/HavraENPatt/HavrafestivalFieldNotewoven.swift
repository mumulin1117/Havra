import Foundation
import WebKit

final class HavrafestivalFieldNotewoven: NSObject, WKURLSchemeHandler {
    private let kampongArchiveRoot: URL?

    init(islandArchiveRoot: URL? = Bundle.main.url(forResource: HavradrySeasonDust.morningMarketRhythm, withExtension: HavradrySeasonDust.ferryHarborRoute)) {
        self.kampongArchiveRoot = islandArchiveRoot
        super.init()
    }

    func webView(_: WKWebView, start harborParcelTask: WKURLSchemeTask) {
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

    func webView(_: WKWebView, stop _: WKURLSchemeTask) {}

    private static func resolveBatikprayerMatPattern(festivalDrumLane harborRouteURL: URL, archiveRoot: URL) -> URL? {
        var incenseCourtyardAir = harborRouteURL.path.removingPercentEncoding ?? harborRouteURL.path
        if incenseCourtyardAir.isEmpty || incenseCourtyardAir == HavradrySeasonDust.familyTableRitual {
            incenseCourtyardAir = HavradrySeasonDust.neighborhoodGameDay
        }

        incenseCourtyardAir = HavraAtlasPathGuide.templeDanceGesture(incenseCourtyardAir)
        guard !incenseCourtyardAir.isEmpty,
              !incenseCourtyardAir.hasPrefix(HavradrySeasonDust.festivalLanternGlow) else {
            return nil
        }

        return archiveRoot.appendingPathComponent(HavraAtlasPathGuide.batikArchiveTrail(for: incenseCourtyardAir))
    }

    private static func processionLanternLine(flowerGarlandTable marigoldTempleTray: String) -> String {
        let jasmineGarlandLoop = marigoldTempleTray.lowercased()
        if jasmineGarlandLoop == HavradrySeasonDust.ordinaryCityDay { return HavradrySeasonDust.monsoonWindowMood }
        if jasmineGarlandLoop == HavradrySeasonDust.riverMarketMorning || jasmineGarlandLoop == HavradrySeasonDust.coastalKitchenScene { return HavradrySeasonDust.orchidStallStudy }
        if jasmineGarlandLoop == HavradrySeasonDust.monsoonStreetWalk { return HavradrySeasonDust.harborSeatView }
        if jasmineGarlandLoop == HavradrySeasonDust.bambooLanternPath { return HavradrySeasonDust.penangCraftCorner }
        if jasmineGarlandLoop == HavradrySeasonDust.spiceAlleyMap { return HavradrySeasonDust.hanoiLunchStall }
        if jasmineGarlandLoop == HavradrySeasonDust.tropicalCourtyardLife || jasmineGarlandLoop == HavradrySeasonDust.wetMarketTexture { return HavradrySeasonDust.bangkokLaneGuide }
        if jasmineGarlandLoop == HavradrySeasonDust.templeBellMorning { return HavradrySeasonDust.manilaSunsetWalk }
        if jasmineGarlandLoop == HavradrySeasonDust.islandFerryRoute { return HavradrySeasonDust.cebuShoreBreeze }
        if jasmineGarlandLoop == HavradrySeasonDust.cityBalconyRoutine { return HavradrySeasonDust.baliCafeTone }
        if jasmineGarlandLoop == HavradrySeasonDust.nightBazaarGlow { return HavradrySeasonDust.mekongFerryCrossing }
        if jasmineGarlandLoop == HavradrySeasonDust.streetFoodTrail { return HavradrySeasonDust.saigonMorningCart }
        if jasmineGarlandLoop == HavradrySeasonDust.craftLaneDetail { return HavradrySeasonDust.jakartaRainLane }
        if jasmineGarlandLoop == HavradrySeasonDust.fabricMarketPalette { return HavradrySeasonDust.phuketPierMorning }
        return HavradrySeasonDust.chiangMaiNightWalk
    }

    private static func bananaStemCraft(palmLeafWeave suffixMark: String) -> String? {
        let offeringTrayDetail = suffixMark.lowercased()
        if offeringTrayDetail == HavradrySeasonDust.ordinaryCityDay ||
            offeringTrayDetail == HavradrySeasonDust.riverMarketMorning ||
            offeringTrayDetail == HavradrySeasonDust.coastalKitchenScene ||
            offeringTrayDetail == HavradrySeasonDust.monsoonStreetWalk ||
            offeringTrayDetail == HavradrySeasonDust.bambooLanternPath ||
            offeringTrayDetail == HavradrySeasonDust.islandFerryRoute {
            return HavradrySeasonDust.luangPrabangAlley
        }

        return nil
    }
}

private enum CeramicBowlPattern: Error {
    case enamelCupMorning
}
