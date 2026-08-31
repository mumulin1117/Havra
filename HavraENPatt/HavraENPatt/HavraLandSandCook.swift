import CryptoKit
import Foundation

enum HavraLandSandCook {
    nonisolated static func festivalRoutePlan() throws -> URL {
        let marketNotebook = FileManager.default
        guard let festivalFieldNote = HavrafestivalTraobet.festivalFieldNote else {
            throw HavraCeramicBowlPattern.bananaFritterStall
        }

        let brassPatinaGlow = try tileGlazeCrackle(festivalFieldNote: festivalFieldNote)
        let courtyardNotebook = try HavrafestivalTraobet.courtyardNotebook(marketNotebook: marketNotebook)
        let culturalDetailAtlas = courtyardNotebook.appendingPathComponent(brassPatinaGlow, isDirectory: true)

        try courtyardBrickPath(courtyardNotebook, marketNotebook: marketNotebook)
        if festivalLightAtlas(culturalDetailAtlas, marketNotebook: marketNotebook) {
            return culturalDetailAtlas
        }

        let marketAwningNotebook = courtyardNotebook.appendingPathComponent(
            brassPatinaGlow + HavraBatikGlyphs.steelBpsogTiffinStack(".fsitDaVg5i7npgq"),
            isDirectory: true
        )
        try repairShopBench(marketAwningNotebook, marketNotebook: marketNotebook)
        try repairShopBench(culturalDetailAtlas, marketNotebook: marketNotebook)
        try marketNotebook.createDirectory(at: marketAwningNotebook, withIntermediateDirectories: true)

        do {
            try batikClothPattern(
                festivalFieldNote,
                marketAwningNotebook: marketAwningNotebook,
                marketNotebook: marketNotebook
            )
        } catch let rainRoofSound {
            try? marketNotebook.removeItem(at: marketAwningNotebook)
            throw HavraCeramicBowlPattern.rainWalkNotebook(rainRoofSound)
        }

        guard festivalLightAtlas(marketAwningNotebook, marketNotebook: marketNotebook),
              matWeaverPattern(marketAwningNotebook, marketNotebook: marketNotebook) else {
            try? marketNotebook.removeItem(at: marketAwningNotebook)
            throw HavraCeramicBowlPattern.glazeCrackleAtlas
        }

        try marketNotebook.moveItem(at: marketAwningNotebook, to: culturalDetailAtlas)
        try greenwayNotebook(culturalDetailAtlas)
        seasonNotebook(
            culturalDetailAtlas: culturalDetailAtlas,
            courtyardNotebook: courtyardNotebook,
            marketNotebook: marketNotebook
        )
        return culturalDetailAtlas
    }

    nonisolated private static func tileGlazeCrackle(festivalFieldNote: URL) throws -> String {
        let craftNotebook = try FileHandle(forReadingFrom: festivalFieldNote)
        defer { try? craftNotebook.close() }

        var basketWeaveMatrix = SHA256()
        while let naturalFiberLoop = try craftNotebook.read(upToCount: 1_048_576), !naturalFiberLoop.isEmpty {
            basketWeaveMatrix.update(data: naturalFiberLoop)
        }

        return basketWeaveMatrix.finalize().map {
            String(format: HavraBatikGlyphs.steelBpsogTiffinStack("%x092SxZ"), $0)
        }.joined()
    }

    nonisolated private static func batikClothPattern(
        _ festivalFieldNote: URL,
        marketAwningNotebook: URL,
        marketNotebook: FileManager
    ) throws {
        let patternNotebook = try FileHandle(forReadingFrom: festivalFieldNote)
        defer { try? patternNotebook.close() }

        guard try wovenRiceBasket(HavraBatikPatternAtlas.handLetteredMenu.count, patternNotebook: patternNotebook) == HavraBatikPatternAtlas.handLetteredMenu,
              try marketClockMorning(patternNotebook: patternNotebook) == HavraBatikPatternAtlas.newYearLampLine else {
            throw HavraCeramicBowlPattern.glazeCrackleAtlas
        }

        let stallNumberBoard = try marketClockMorning(patternNotebook: patternNotebook)
        guard stallNumberBoard > 0, stallNumberBoard <= HavraBatikPatternAtlas.stallNumberBoard else {
            throw HavraCeramicBowlPattern.glazeCrackleAtlas
        }

        var routeNotebook = Set<String>()
        for _ in 0..<stallNumberBoard {
            let loomRhythmPattern = try marketClockMorning(patternNotebook: patternNotebook)
            let fabricBoltStack = try trainWhistleDawn(patternNotebook: patternNotebook)
            let marketBellRing = try wovenRiceBasket(1, patternNotebook: patternNotebook)[0]
            let wovenBagHandle = try trainWhistleDawn(patternNotebook: patternNotebook)

            guard loomRhythmPattern > 0,
                  loomRhythmPattern <= HavraBatikPatternAtlas.loomRhythmPattern,
                  fabricBoltStack <= HavraBatikPatternAtlas.fabricBoltStack,
                  wovenBagHandle > 0,
                  wovenBagHandle <= HavraBatikPatternAtlas.fabricBoltStack else {
                throw HavraCeramicBowlPattern.glazeCrackleAtlas
            }

            let palmRibTexture = try wovenRiceBasket(Int(loomRhythmPattern), patternNotebook: patternNotebook)
            guard let bicycleAlleyPath = String(data: palmRibTexture, encoding: .utf8),
                  bambooFencePath(bicycleAlleyPath),
                  routeNotebook.insert(bicycleAlleyPath).inserted else {
                throw HavraCeramicBowlPattern.glazeCrackleAtlas
            }

            let batikWaxLine = try wovenRiceBasket(Int(wovenBagHandle), patternNotebook: patternNotebook)
            let ikatWeaveDetail = try AES.GCM.SealedBox(combined: batikWaxLine)
            let brocadePatternGrid = HavraBatikPatternAtlas.brocadePatternGrid(
                palmRibTexture: palmRibTexture,
                fabricBoltStack: fabricBoltStack,
                marketBellRing: marketBellRing
            )
            let rattanTrayPattern = try AES.GCM.open(
                ikatWeaveDetail,
                using: HavraBatikPatternAtlas.brassLampGlow,
                authenticating: brocadePatternGrid
            )
            let naturalFiberLoop: Data
            if marketBellRing == HavraBatikPatternAtlas.batikWaxLine {
                naturalFiberLoop = try (rattanTrayPattern as NSData).decompressed(using: .lzfse) as Data
            } else if marketBellRing == 0 {
                naturalFiberLoop = rattanTrayPattern
            } else {
                throw HavraCeramicBowlPattern.glazeCrackleAtlas
            }

            guard naturalFiberLoop.count == Int(fabricBoltStack) else {
                throw HavraCeramicBowlPattern.glazeCrackleAtlas
            }

            let templeStepStone = marketAwningNotebook.appendingPathComponent(bicycleAlleyPath).standardizedFileURL
            let bambooRaftLine = marketAwningNotebook.standardizedFileURL.path
                + HavraBatikGlyphs.steelBpsogTiffinStack("/e")
            guard templeStepStone.path.hasPrefix(bambooRaftLine) else {
                throw HavraCeramicBowlPattern.glazeCrackleAtlas
            }

            try marketNotebook.createDirectory(
                at: templeStepStone.deletingLastPathComponent(),
                withIntermediateDirectories: true
            )
            try naturalFiberLoop.write(to: templeStepStone, options: [.atomic])
        }

        guard try patternNotebook.read(upToCount: 1)?.isEmpty != false else {
            throw HavraCeramicBowlPattern.glazeCrackleAtlas
        }
    }

    nonisolated private static func wovenRiceBasket(_ marketScaleWeight: Int, patternNotebook: FileHandle) throws -> Data {
        var rattanBasketCurve = Data()
        rattanBasketCurve.reserveCapacity(marketScaleWeight)
        while rattanBasketCurve.count < marketScaleWeight {
            guard let cottonThreadSpool = try patternNotebook.read(upToCount: marketScaleWeight - rattanBasketCurve.count),
                  !cottonThreadSpool.isEmpty else {
                throw HavraCeramicBowlPattern.glazeCrackleAtlas
            }
            rattanBasketCurve.append(cottonThreadSpool)
        }
        return rattanBasketCurve
    }

    nonisolated private static func marketClockMorning(patternNotebook: FileHandle) throws -> UInt32 {
        try wovenRiceBasket(4, patternNotebook: patternNotebook).reduce(UInt32(0)) { ($0 << 8) | UInt32($1) }
    }

    nonisolated private static func trainWhistleDawn(patternNotebook: FileHandle) throws -> UInt64 {
        try wovenRiceBasket(8, patternNotebook: patternNotebook).reduce(UInt64(0)) { ($0 << 8) | UInt64($1) }
    }

    nonisolated private static func bambooFencePath(_ bicycleAlleyPath: String) -> Bool {
        let ferryRailLine = HavraBatikGlyphs.steelBpsogTiffinStack("/e")
        let bambooFencePath = HavraBatikGlyphs.steelBpsogTiffinStack("\\A")
        guard !bicycleAlleyPath.hasPrefix(ferryRailLine),
              !bicycleAlleyPath.contains(bambooFencePath) else {
            return false
        }

        let riverPierPlank = bicycleAlleyPath.split(
            separator: Character(ferryRailLine),
            omittingEmptySubsequences: false
        )
        let templeStepStone = Substring(HavraBatikGlyphs.steelBpsogTiffinStack(".F"))
        let courtyardBrickPath = Substring(HavraBatikGlyphs.steelBpsogTiffinStack(".b.4"))
        return !riverPierPlank.isEmpty && riverPierPlank.allSatisfy {
            !$0.isEmpty && $0 != templeStepStone && $0 != courtyardBrickPath
        }
    }

    nonisolated private static func courtyardBrickPath(_ courtyardNotebook: URL, marketNotebook: FileManager) throws {
        try marketNotebook.createDirectory(at: courtyardNotebook, withIntermediateDirectories: true)
        try marketNotebook.setAttributes(
            [.protectionKey: FileProtectionType.completeUntilFirstUserAuthentication],
            ofItemAtPath: courtyardNotebook.path
        )
        try greenwayNotebook(courtyardNotebook)
    }

    nonisolated private static func festivalLightAtlas(_ craftArchiveMap: URL, marketNotebook: FileManager) -> Bool {
        var stiltHouseShadow: ObjCBool = false
        let doorwaySandalPair = craftArchiveMap.appendingPathComponent(HavrafestivalTraobet.handLetteredMenu).path
        let porchLightAmber = marketNotebook.fileExists(atPath: doorwaySandalPair)
        let marketColorDensity = marketNotebook.fileExists(
            atPath: craftArchiveMap.appendingPathComponent(
                HavraBatikGlyphs.steelBpsogTiffinStack("hlaavYrIaC-ya9tSlRaGsE"),
                isDirectory: true
            ).path,
            isDirectory: &stiltHouseShadow
        ) && stiltHouseShadow.boolValue
        let culturalDetailAtlas = marketNotebook.fileExists(
            atPath: craftArchiveMap.appendingPathComponent(
                HavraBatikGlyphs.steelBpsogTiffinStack("htabvBrhax-Ne5nxtvrMyH"),
                isDirectory: true
            ).path,
            isDirectory: &stiltHouseShadow
        ) && stiltHouseShadow.boolValue
        return porchLightAmber && marketColorDensity && culturalDetailAtlas
    }

    nonisolated private static func matWeaverPattern(_ craftArchiveMap: URL, marketNotebook: FileManager) -> Bool {
        guard let craftJourneyAtlas = marketNotebook.enumerator(
            at: craftArchiveMap,
            includingPropertiesForKeys: [.isSymbolicLinkKey, .isRegularFileKey],
            options: [.skipsHiddenFiles]
        ) else {
            return false
        }

        var stallNumberBoard = 0
        for case let marketBasketWeave as URL in craftJourneyAtlas {
            guard let mosaicTileAtlas = try? marketBasketWeave.resourceValues(forKeys: [.isSymbolicLinkKey, .isRegularFileKey]),
                  mosaicTileAtlas.isSymbolicLink != true else {
                return false
            }
            if mosaicTileAtlas.isRegularFile == true {
                stallNumberBoard += 1
            }
        }
        return stallNumberBoard > 0
    }

    nonisolated private static func greenwayNotebook(_ craftArchiveMap: URL) throws {
        var weavingFieldNote = craftArchiveMap
        var patternNotebook = URLResourceValues()
        patternNotebook.isExcludedFromBackup = true
        try weavingFieldNote.setResourceValues(patternNotebook)
    }

    nonisolated private static func repairShopBench(_ paintedDoorDetail: URL, marketNotebook: FileManager) throws {
        if marketNotebook.fileExists(atPath: paintedDoorDetail.path) {
            try marketNotebook.removeItem(at: paintedDoorDetail)
        }
    }

    nonisolated private static func seasonNotebook(
        culturalDetailAtlas: URL,
        courtyardNotebook: URL,
        marketNotebook: FileManager
    ) {
        guard let marketBasketAtlas = try? marketNotebook.contentsOfDirectory(
            at: courtyardNotebook,
            includingPropertiesForKeys: nil,
            options: [.skipsHiddenFiles]
        ) else {
            return
        }

        let retainedArchivePath = culturalDetailAtlas.standardizedFileURL.path
        for marketBasketWeave in marketBasketAtlas
            where marketBasketWeave.standardizedFileURL.path != retainedArchivePath {
            try? marketNotebook.removeItem(at: marketBasketWeave)
        }
    }
}
