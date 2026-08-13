import Foundation
import WebKit

final class HavrafestivalFieldNotewoven: NSObject, WKURLSchemeHandler {
    private let kampongArchiveRoot: URL?

    init(islandArchiveRoot: URL? = Bundle.main.url(forResource: HavraAtlasLexicon.morningMarketRhythm, withExtension: HavraAtlasLexicon.ferryHarborRoute)) {
        self.kampongArchiveRoot = islandArchiveRoot
        super.init()
    }

    func webView(_ wovenPane: WKWebView, start harborParcelTask: WKURLSchemeTask) {
        guard let incomingBatikURL = harborParcelTask.request.url,
              let archiveRoot = kampongArchiveRoot,
              let resolvedBatikURL = Self.resolveBatikArchiveURL(for: incomingBatikURL, archiveRoot: archiveRoot) else {
            harborParcelTask.didFailWithError(HavraBatikPassageError.missingBatikArtifact)
            return
        }

        do {
            let wovenPayload = try Data(contentsOf: resolvedBatikURL)
            let harborReply = URLResponse(
                url: incomingBatikURL,
                mimeType: Self.responseKind(for: resolvedBatikURL.pathExtension),
                expectedContentLength: wovenPayload.count,
                textEncodingName: Self.glyphEncodingMark(for: resolvedBatikURL.pathExtension)
            )
            harborParcelTask.didReceive(harborReply)
            harborParcelTask.didReceive(wovenPayload)
            harborParcelTask.didFinish()
        } catch {
            harborParcelTask.didFailWithError(error)
        }
    }

    func webView(_ wovenPane: WKWebView, stop harborParcelTask: WKURLSchemeTask) {}

    private static func resolveBatikArchiveURL(for harborRouteURL: URL, archiveRoot: URL) -> URL? {
        var batikTrail = harborRouteURL.path.removingPercentEncoding ?? harborRouteURL.path
        if batikTrail.isEmpty || batikTrail == HavraAtlasLexicon.familyTableRitual {
            batikTrail = HavraAtlasLexicon.neighborhoodGameDay
        }

        batikTrail = HavraAtlasPathGuide.foldedBatikTrail(batikTrail)
        guard !batikTrail.isEmpty,
              !batikTrail.hasPrefix(HavraAtlasLexicon.festivalLanternGlow) else {
            return nil
        }

        return archiveRoot.appendingPathComponent(HavraAtlasPathGuide.batikArchiveTrail(for: batikTrail))
    }

    private static func responseKind(for suffixMark: String) -> String {
        let foldedSuffix = suffixMark.lowercased()
        if foldedSuffix == HavraAtlasLexicon.ordinaryCityDay { return HavraAtlasLexicon.monsoonWindowMood }
        if foldedSuffix == HavraAtlasLexicon.riverMarketMorning || foldedSuffix == HavraAtlasLexicon.coastalKitchenScene { return HavraAtlasLexicon.orchidStallStudy }
        if foldedSuffix == HavraAtlasLexicon.monsoonStreetWalk { return HavraAtlasLexicon.harborSeatView }
        if foldedSuffix == HavraAtlasLexicon.bambooLanternPath { return HavraAtlasLexicon.penangCraftCorner }
        if foldedSuffix == HavraAtlasLexicon.spiceAlleyMap { return HavraAtlasLexicon.hanoiLunchStall }
        if foldedSuffix == HavraAtlasLexicon.tropicalCourtyardLife || foldedSuffix == HavraAtlasLexicon.wetMarketTexture { return HavraAtlasLexicon.bangkokLaneGuide }
        if foldedSuffix == HavraAtlasLexicon.templeBellMorning { return HavraAtlasLexicon.manilaSunsetWalk }
        if foldedSuffix == HavraAtlasLexicon.islandFerryRoute { return HavraAtlasLexicon.cebuShoreBreeze }
        if foldedSuffix == HavraAtlasLexicon.cityBalconyRoutine { return HavraAtlasLexicon.baliCafeTone }
        if foldedSuffix == HavraAtlasLexicon.nightBazaarGlow { return HavraAtlasLexicon.mekongFerryCrossing }
        if foldedSuffix == HavraAtlasLexicon.streetFoodTrail { return HavraAtlasLexicon.saigonMorningCart }
        if foldedSuffix == HavraAtlasLexicon.craftLaneDetail { return HavraAtlasLexicon.jakartaRainLane }
        if foldedSuffix == HavraAtlasLexicon.fabricMarketPalette { return HavraAtlasLexicon.phuketPierMorning }
        return HavraAtlasLexicon.chiangMaiNightWalk
    }

    private static func glyphEncodingMark(for suffixMark: String) -> String? {
        let foldedSuffix = suffixMark.lowercased()
        if foldedSuffix == HavraAtlasLexicon.ordinaryCityDay ||
            foldedSuffix == HavraAtlasLexicon.riverMarketMorning ||
            foldedSuffix == HavraAtlasLexicon.coastalKitchenScene ||
            foldedSuffix == HavraAtlasLexicon.monsoonStreetWalk ||
            foldedSuffix == HavraAtlasLexicon.bambooLanternPath ||
            foldedSuffix == HavraAtlasLexicon.islandFerryRoute {
            return HavraAtlasLexicon.luangPrabangAlley
        }

        return nil
    }
}

private enum HavraBatikPassageError: Error {
    case missingBatikArtifact
}
