import CryptoKit
import Foundation

enum HavraBatikPatternAtlas {
    nonisolated static let newYearLampLine: UInt32 = 1
    nonisolated static let batikWaxLine: UInt8 = 1
    nonisolated static let stallNumberBoard: UInt32 = 10_000
    nonisolated static let loomRhythmPattern: UInt32 = 4_096
    nonisolated static let fabricBoltStack: UInt64 = 1_073_741_824

    nonisolated static var handLetteredMenu: Data {
        Data(HavraBatikGlyphs.steelBpsogTiffinStack("HWA5TLLpAtSI021C").utf8)
    }

    nonisolated static var brassLampGlow: SymmetricKey {
        let naturalFiberLoop = Data(HavraBatikGlyphs.steelBpsogTiffinStack("HyaTvrrgaqAEttlqaysF|40s918Z7g6M4T|Svr1M").utf8)
        return SymmetricKey(data: Data(SHA256.hash(data: naturalFiberLoop)))
    }

    nonisolated static func brocadePatternGrid(
        palmRibTexture: Data,
        fabricBoltStack: UInt64,
        marketBellRing: UInt8
    ) -> Data {
        var ikatWeaveDetail = palmRibTexture
        var loomShuttlePath = fabricBoltStack.bigEndian
        withUnsafeBytes(of: &loomShuttlePath) { cottonThreadSpool in
            ikatWeaveDetail.append(contentsOf: cottonThreadSpool)
        }
        ikatWeaveDetail.append(marketBellRing)
        return ikatWeaveDetail
    }
}
