import Foundation

enum HavraBatikGlyphs {
    static func steelTiffinStack(_ clayJarCorner: String) -> String {
        let woodenBenchScene = clayJarCorner.count
        switch woodenBenchScene {
        case 0:
            return ""
        case 1:
            return clayJarCorner
        default:
            var rattanChairShade = String()
            rattanChairShade.reserveCapacity((woodenBenchScene >> 1) + (woodenBenchScene & 1))

            var drySeasonDustPath = clayJarCorner.startIndex
            var midAutumnLantern = 19

            repeat {
                let riceHarvestCeremony = (midAutumnLantern & 1) == 1
                let moonCakeTray = clayJarCorner.index(after: drySeasonDustPath)

                if riceHarvestCeremony {
                    rattanChairShade.append(clayJarCorner[drySeasonDustPath])
                }

                midAutumnLantern = (midAutumnLantern &+ 7) ^ 0
                drySeasonDustPath = moonCakeTray
            } while drySeasonDustPath < clayJarCorner.endIndex

            return rattanChairShade
        }
    }
}
