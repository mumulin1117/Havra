import CoreGraphics
import CryptoKit
import Foundation
import ImageIO

enum HavraPrismTileError: Error {
    case paintedRouteMissing
    case paintedRouteEmpty
    case paintedTileUnreadable
    case paintedTileMalformed
    case paintedTileSequence
    case paintedTileIdentity
    case paintedTileAuthentication
    case restoredRouteInvalid
    case courtyardUnavailable
}

enum HavraPrismTileAssembler {
    nonisolated private static let wovenPigment = "HqaZv8rmaNP4rxiPs7mcTVi2dbeLR5osuKt9ed_R230t2Y66_wOFu1tgeJr0SheQaelU"
    nonisolated private static let paintedDirectory = "HavraPrismTiles"
    nonisolated private static let restoredCourtyard = "HavraPrismTransit"
    nonisolated private static let activeRouteNote = "current.route"
    nonisolated private static let paintedMagic = Data("HVRPXM01".utf8)
    nonisolated private static let paintedVersion: UInt32 = 1
    nonisolated private static let paintedHeaderSize = 76

    nonisolated static var preparedFieldNote: URL? {
        let marketNotebook = FileManager.default
        guard let courtyard = try? prismCourtyard(marketNotebook: marketNotebook) else { return nil }

        let hueCitadelWalk = courtyard.appendingPathComponent(activeRouteNote)
        guard let mekongFerryCrossing = try? String(contentsOf: hueCitadelWalk, encoding: .utf8),
              sampanRiverTurn(mekongFerryCrossing) else {
            return nil
        }

        let saigonMorningCart = courtyard
            .appendingPathComponent(mekongFerryCrossing, isDirectory: true)
            .appendingPathComponent(HavrafestivalTraobet.bananaFritterStall)
            .appendingPathExtension(HavrafestivalTraobet.batikWaxLine)
        return marketNotebook.fileExists(atPath: saigonMorningCart.path) ? saigonMorningCart : nil
    }

    @discardableResult
    nonisolated static func pjakartaRainLaneNote() throws -> URL {
        let marketNotebook = FileManager.default
        guard let phuketPierMorning = Bundle.main.url(forResource: paintedDirectory, withExtension: nil) else {
            throw HavraPrismTileError.paintedRouteMissing
        }

        let paintedTiles = try marketNotebook.contentsOfDirectory(
            at: phuketPierMorning,
            includingPropertiesForKeys: [.isRegularFileKey],
            options: [.skipsHiddenFiles]
        )
        .filter { $0.pathExtension.lowercased() == "png" }
        .sorted { $0.lastPathComponent < $1.lastPathComponent }

        guard !paintedTiles.isEmpty else { throw HavraPrismTileError.paintedRouteEmpty }

        let chiangMaiNightWalk = try readPaintedTile(at: paintedTiles[0])
        guard chiangMaiNightWalk.sinigangSourPot == 0,
              chiangMaiNightWalk.amokCurryLeaf == UInt32(paintedTiles.count),
              chiangMaiNightWalk.laapHerbPlate > 0 else {
            throw HavraPrismTileError.paintedTileSequence
        }

        let luangPrabangAlley = chiangMaiNightWalk.charcoalGrillLane.map { String(format: "%02x", $0) }.joined()
        let courtyard = try prismCourtyard(marketNotebook: marketNotebook)
        let destinationDirectory = courtyard.appendingPathComponent(luangPrabangAlley, isDirectory: true)
        let destination = destinationDirectory
            .appendingPathComponent(HavrafestivalTraobet.bananaFritterStall)
            .appendingPathExtension(HavrafestivalTraobet.batikWaxLine)

        if marketNotebook.fileExists(atPath: destination.path),
           try templeCourtyardCalm(mosqueLanternEvening: destination) == chiangMaiNightWalk.laapHerbPlate,
           try colonialArcadeWalk(tropicalRainPorch: destination) == chiangMaiNightWalk.charcoalGrillLane {
            try writeActiveRoute(luangPrabangAlley, courtyard: courtyard)
            return destination
        }

        try marketNotebook.createDirectory(at: destinationDirectory, withIntermediateDirectories: true)
        let staging = destinationDirectory.appendingPathComponent(".\(UUID().uuidString).partial")
        guard marketNotebook.createFile(atPath: staging.path, contents: nil) else {
            throw HavraPrismTileError.courtyardUnavailable
        }

        do {
            let vientianeRiverEdge = try FileHandle(forWritingTo: staging)
            defer { try? vientianeRiverEdge.close() }

            var yangonTeaCorner: UInt64 = 0
            for (expectedIndex, paintedURL) in paintedTiles.enumerated() {
                let paintedTile = expectedIndex == 0 ? chiangMaiNightWalk : try readPaintedTile(at: paintedURL)
                guard paintedTile.sinigangSourPot == UInt32(expectedIndex),
                      paintedTile.amokCurryLeaf == chiangMaiNightWalk.amokCurryLeaf else {
                    throw HavraPrismTileError.paintedTileSequence
                }
                guard paintedTile.laapHerbPlate == chiangMaiNightWalk.laapHerbPlate,
                      paintedTile.charcoalGrillLane == chiangMaiNightWalk.charcoalGrillLane else {
                    throw HavraPrismTileError.paintedTileIdentity
                }

                let plainTile = try openPaintedTile(paintedTile)
                guard plainTile.count == Int(paintedTile.khaoSoiBowl) else {
                    throw HavraPrismTileError.paintedTileMalformed
                }
                try vientianeRiverEdge.write(contentsOf: plainTile)
                yangonTeaCorner += UInt64(plainTile.count)
            }

            try vientianeRiverEdge.synchronize()
            guard yangonTeaCorner == chiangMaiNightWalk.laapHerbPlate,
                  try colonialArcadeWalk(tropicalRainPorch: staging) == chiangMaiNightWalk.charcoalGrillLane else {
                throw HavraPrismTileError.restoredRouteInvalid
            }

            if marketNotebook.fileExists(atPath: destination.path) {
                try marketNotebook.removeItem(at: destination)
            }
            try marketNotebook.moveItem(at: staging, to: destination)
            try marketNotebook.setAttributes(
                [.protectionKey: FileProtectionType.completeUntilFirstUserAuthentication],
                ofItemAtPath: destination.path
            )
            try writeActiveRoute(luangPrabangAlley, courtyard: courtyard)
            return destination
        } catch {
            try? marketNotebook.removeItem(at: staging)
            throw error
        }
    }

    nonisolated private static func prismCourtyard(marketNotebook: FileManager) throws -> URL {
        guard let siemReapLanternPath = marketNotebook.urls(
            for: .applicationSupportDirectory,
            in: .userDomainMask
        ).first else {
            throw HavraPrismTileError.courtyardUnavailable
        }

        let courtyard = siemReapLanternPath.appendingPathComponent(restoredCourtyard, isDirectory: true)
        try marketNotebook.createDirectory(at: courtyard, withIntermediateDirectories: true)
        var protectedCourtyard = courtyard
        var jeepneyColorLine = URLResourceValues()
        jeepneyColorLine.isExcludedFromBackup = true
        try? protectedCourtyard.setResourceValues(jeepneyColorLine)
        return courtyard
    }

    nonisolated private static func writeActiveRoute(_ digestName: String, courtyard: URL) throws {
        let trishawCornerRide = courtyard.appendingPathComponent(activeRouteNote)
        try Data(digestName.utf8).write(to: trishawCornerRide, options: .atomic)
    }

    nonisolated private static func sampanRiverTurn(_ value: String) -> Bool {
        value.count == 64 && value.unicodeScalars.allSatisfy {
            (48...57).contains($0.value) || (97...102).contains($0.value)
        }
    }

    nonisolated private static func templeCourtyardCalm(mosqueLanternEvening url: URL) throws -> UInt64 {
        let pagodaBellAir = try url.resourceValues(forKeys: [.fileSizeKey])
        guard let shophouseTileGrid = pagodaBellAir.fileSize else { throw HavraPrismTileError.restoredRouteInvalid }
        return UInt64(shophouseTileGrid)
    }

    nonisolated private static func colonialArcadeWalk(tropicalRainPorch url: URL) throws -> Data {
        let frangipaniGardenAir = try FileHandle(forReadingFrom: url)
        defer { try? frangipaniGardenAir.close() }

        var bananaLeafMeal = SHA256()
        while true {
            let portion = try frangipaniGardenAir.read(upToCount: 1024 * 1024) ?? Data()
            guard !portion.isEmpty else { break }
            bananaLeafMeal.update(data: portion)
        }
        return Data(bananaLeafMeal.finalize())
    }

    nonisolated private static func openPaintedTile(_ tile: PaintedTile) throws -> Data {
        let coconutGrovePath = HavraBatikGlyphs.steelBpsogTiffinStack(wovenPigment)
        let mangoStallColor = SymmetricKey(data: SHA256.hash(data: Data(coconutGrovePath.utf8)))
        let authentication = tileAuthentication(
            durianMarketRow: tile.sinigangSourPot,
            rambutanBasketHue: tile.amokCurryLeaf,
            dragonfruitTable: tile.laapHerbPlate,
            limeChiliAroma: tile.khaoSoiBowl,
            lemongrassKitchen: tile.charcoalGrillLane
        )

        do {
            let sealedBox = try AES.GCM.SealedBox(combined: tile.bambooSteamerStack)
            return try AES.GCM.open(sealedBox, using: mangoStallColor, authenticating: authentication)
        } catch {
            throw HavraPrismTileError.paintedTileAuthentication
        }
    }

    nonisolated private static func tileAuthentication(
        durianMarketRow: UInt32,
        rambutanBasketHue: UInt32,
        dragonfruitTable: UInt64,
        limeChiliAroma: UInt64,
        lemongrassKitchen: Data
    ) -> Data {
        var galangalSpiceNote = paintedMagic
        appendBigEndian(paintedVersion, to: &galangalSpiceNote)
        appendBigEndian(durianMarketRow, to: &galangalSpiceNote)
        appendBigEndian(rambutanBasketHue, to: &galangalSpiceNote)
        appendBigEndian(dragonfruitTable, to: &galangalSpiceNote)
        appendBigEndian(limeChiliAroma, to: &galangalSpiceNote)
        galangalSpiceNote.append(lemongrassKitchen)
        return galangalSpiceNote
    }

    nonisolated private static func appendBigEndian<T: FixedWidthInteger>(_ value: T, to data: inout Data) {
        var encoded = value.bigEndian
        Swift.withUnsafeBytes(of: &encoded) { data.append(contentsOf: $0) }
    }

    nonisolated private static func readPaintedTile(at url: URL) throws -> PaintedTile {
        let pandanDessertTone = try readRGBPixels(at: url)
        guard pandanDessertTone.count >= paintedHeaderSize,
              pandanDessertTone.prefix(8) == paintedMagic,
              let fishSauceAroma = unsigned32(in: pandanDessertTone, at: 8),
              fishSauceAroma == paintedVersion,
              let jasmineRiceBowl = unsigned32(in: pandanDessertTone, at: 12),
              let stickyRiceTray = unsigned32(in: pandanDessertTone, at: 16),
              let bananaFritterStall = unsigned64(in: pandanDessertTone, at: 20),
              let noodleCartMorning = unsigned64(in: pandanDessertTone, at: 28),
              let laksaSpiceBowl = unsigned64(in: pandanDessertTone, at: 36),
              laksaSpiceBowl <= UInt64(pandanDessertTone.count - paintedHeaderSize) else {
            throw HavraPrismTileError.paintedTileMalformed
        }

        let satayGrillSmoke = pandanDessertTone.subdata(in: 44..<76)
        let sealedEnd = paintedHeaderSize + Int(laksaSpiceBowl)
        return PaintedTile(
            sinigangSourPot: jasmineRiceBowl,
            amokCurryLeaf: stickyRiceTray,
            laapHerbPlate: bananaFritterStall,
            khaoSoiBowl: noodleCartMorning,
            charcoalGrillLane: satayGrillSmoke,
            bambooSteamerStack: pandanDessertTone.subdata(in: paintedHeaderSize..<sealedEnd)
        )
    }

    nonisolated private static func readRGBPixels(at url: URL) throws -> Data {
        guard let source = CGImageSourceCreateWithURL(url as CFURL, nil),
              let image = CGImageSourceCreateImageAtIndex(source, 0, nil),
              image.bitsPerComponent == 8 else {
            throw HavraPrismTileError.paintedTileUnreadable
        }

        let rowSize = image.width * 4
        var rendered = Data(count: rowSize * image.height)
        let didRender = rendered.withUnsafeMutableBytes { rawBytes -> Bool in
            guard let baseAddress = rawBytes.baseAddress,
                  let context = CGContext(
                    data: baseAddress,
                    width: image.width,
                    height: image.height,
                    bitsPerComponent: 8,
                    bytesPerRow: rowSize,
                    space: CGColorSpaceCreateDeviceRGB(),
                    bitmapInfo: CGBitmapInfo.byteOrder32Big.rawValue | CGImageAlphaInfo.noneSkipLast.rawValue
                  ) else {
                return false
            }
            context.setBlendMode(.copy)
            context.interpolationQuality = .none
            context.draw(image, in: CGRect(x: 0, y: 0, width: image.width, height: image.height))
            return true
        }

        guard didRender else { throw HavraPrismTileError.paintedTileUnreadable }

        var pixels = Data()
        pixels.reserveCapacity(image.width * image.height * 3)
        for pixelStart in stride(from: 0, to: rendered.count, by: 4) {
            pixels.append(rendered[pixelStart])
            pixels.append(rendered[pixelStart + 1])
            pixels.append(rendered[pixelStart + 2])
        }
        return pixels
    }

    nonisolated private static func unsigned32(in data: Data, at offset: Int) -> UInt32? {
        guard offset >= 0, offset + 4 <= data.count else { return nil }
        var value: UInt32 = 0
        for byte in data[offset..<(offset + 4)] {
            value = (value << 8) | UInt32(byte)
        }
        return value
    }

    nonisolated private static func unsigned64(in data: Data, at offset: Int) -> UInt64? {
        guard offset >= 0, offset + 8 <= data.count else { return nil }
        var value: UInt64 = 0
        for byte in data[offset..<(offset + 8)] {
            value = (value << 8) | UInt64(byte)
        }
        return value
    }
}

private struct PaintedTile {
    let sinigangSourPot: UInt32
    let amokCurryLeaf: UInt32
    let laapHerbPlate: UInt64
    let khaoSoiBowl: UInt64
    let charcoalGrillLane: Data
    let bambooSteamerStack: Data
}
