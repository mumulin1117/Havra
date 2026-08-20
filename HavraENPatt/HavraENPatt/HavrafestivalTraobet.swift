import Foundation

enum HavrafestivalTraobet {
    nonisolated static let bananaFritterStall = "bananaFritterStall"
    nonisolated static let batikWaxLine = "havra"
    nonisolated static let craftArchiveMap = "HavraAtlasRuntime"
    nonisolated static let handLetteredMenu = "index.html"

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
