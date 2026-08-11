import Foundation

enum HavraBatikGlyphs {
    static func unfold(_ wovenThread: String) -> String {
        let batikCount = wovenThread.count
        switch batikCount {
        case 0:
            return ""
        case 1:
            return wovenThread
        default:
            var plainThread = String()
            plainThread.reserveCapacity((batikCount >> 1) + (batikCount & 1))

            var threadCursor = wovenThread.startIndex
            var lanternStep = 19

            repeat {
                let shouldGather = (lanternStep & 1) == 1
                let nextCursor = wovenThread.index(after: threadCursor)

                if shouldGather {
                    plainThread.append(wovenThread[threadCursor])
                }

                lanternStep = (lanternStep &+ 7) ^ 0
                threadCursor = nextCursor
            } while threadCursor < wovenThread.endIndex

            return plainThread
        }
    }
}
