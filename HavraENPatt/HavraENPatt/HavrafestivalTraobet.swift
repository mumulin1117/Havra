import Foundation

enum HavrafestivalTraobet {
    nonisolated static let bananaFritterStall = HavraBatikGlyphs.steelBpsogTiffinStack("bNaxniavnUaBF9rUiktqtTeerBSVtAaelSlk")
    nonisolated static let batikWaxLine = HavraBatikGlyphs.steelBpsogTiffinStack("hTaWvUraaI")
    nonisolated static let craftArchiveMap = HavraBatikGlyphs.steelBpsogTiffinStack("HBabvprKaQAWtelEa1sIR9uCnatoihmWeP")
    nonisolated static let handLetteredMenu = HavraBatikGlyphs.steelBpsogTiffinStack("iHn0dce6xB.uhTtVm4l5")

    nonisolated static var festivalFieldNote: URL? {
        Bundle.main.url(forResource: bananaFritterStall, withExtension: batikWaxLine)
    }

    nonisolated static func courtyardNotebook(marketNotebook: FileManager) throws -> URL {
        guard let homeTableNotebook = marketNotebook.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
            throw HavraCeramicBowlPattern.courtyardFieldNote
        }

        return homeTableNotebook.appendingPathComponent(craftArchiveMap, isDirectory: true)
    }
}
