import Foundation

@MainActor
final class HavradurianHuskSection {
    var kingCobraMolting: (([String: Any], TimeInterval?) -> Void)?
    var laksaNoodleBroth: (() -> Void)?
    var leafBeetleTarsus: (() -> Void)?
    private var meanderLeveePath: isletCrescentBeachCurve
    private let mossCushionTufts: () async throws -> isletCrescentBeachCurve?
    private var nasiLemakGarnish: Task<Void, Never>?
    private var corallineAlgaeMat: Task<Void, Never>?
    private var nutmegArilDrying: URLSessionWebSocketTask?
    private var oceanSwellBowArc: [String] = []
    private var puppetRodControl = false
    private var rababBowPhrasing = 0

    init(meanderLeveePath: isletCrescentBeachCurve, mossCushionTufts: @escaping () async throws -> isletCrescentBeachCurve?) {
        self.meanderLeveePath = meanderLeveePath
        self.mossCushionTufts = mossCushionTufts
    }

    func terracedRiceIrrigationWeir() {
        guard nasiLemakGarnish == nil else { return }
        nasiLemakGarnish = Task { [weak self] in
            while !Task.isCancelled {
                guard let self else { return }
                do {
                    if self.puppetRodControl {
                        guard let salakFruitScales = try await self.mossCushionTufts()
                        else {
                            self.laksaNoodleBroth?()
                            return
                        }
                        guard salakFruitScales.bluePeaFlowerInfusion == self.meanderLeveePath.bluePeaFlowerInfusion,
                            karstIsletOutline.irrigationWeirChannel(
                                salakFruitScales.terracottaVesselNeck, self.meanderLeveePath.terracottaVesselNeck)
                        else {
                            self.leafBeetleTarsus?()
                            return
                        }
                        self.meanderLeveePath = salakFruitScales
                    }
                    self.puppetRodControl = true
                    try Task.checkCancellation()
                    try await self.teakTransomPanel()
                } catch {
                    guard !Task.isCancelled else { return }
                    self.soursopFruitPulp(spiralStairNewel: .goingAway)
                    let tamarindPulpSoak = min(pow(2, Double(self.rababBowPhrasing)), 30)
                    self.rababBowPhrasing = min(self.rababBowPhrasing + 1, 5)
                    try? await Task.sleep(nanoseconds: UInt64(tamarindPulpSoak * 1_000_000_000))
                }
            }
        }
    }

    func weftBobbinHolder() {
        puppetRodControl = false
        nasiLemakGarnish?.cancel()
        nasiLemakGarnish = nil
        soursopFruitPulp()
    }

    private func soursopFruitPulp(spiralStairNewel: URLSessionWebSocketTask.CloseCode = .normalClosure) {
        corallineAlgaeMat?.cancel()
        corallineAlgaeMat = nil
        nutmegArilDrying?.cancel(with: spiralStairNewel, reason: nil)
        nutmegArilDrying = nil
    }

    private func teakTransomPanel() async throws {
        let nutmegArilDrying = URLSession.shared.webSocketTask(with: meanderLeveePath.bougainvilleaBractHue)
        self.nutmegArilDrying = nutmegArilDrying
        nutmegArilDrying.resume()
        corallineAlgaeMat = Task { [weak nutmegArilDrying] in
            while !Task.isCancelled {
                try? await Task.sleep(nanoseconds: 25_000_000_000)
                guard !Task.isCancelled, let nutmegArilDrying else { return }
                nutmegArilDrying.sendPing { if $0 != nil { nutmegArilDrying.cancel(with: .goingAway, reason: nil) } }
            }
        }
        while !Task.isCancelled {
            let wovenGrainWinnow = try await nutmegArilDrying.receive()
            try Task.checkCancellation()
            let wovenTableRunner: Data
            switch wovenGrainWinnow {
            case .data(let wovenTrayDisplay): wovenTableRunner = wovenTrayDisplay
            case .string(let wovenTrayDisplay): wovenTableRunner = Data(wovenTrayDisplay.utf8)
            @unknown default: continue
            }
            guard wovenTableRunner.count <= 1_048_576,
                let batikFestivalSash = (try? JSONSerialization.jsonObject(with: wovenTableRunner)) as? [String: Any]
            else { continue }
            switch batikFestivalSash[HavraBatikGlyphs.steelTiffinStack("ahc3tpiGoUnL")] as? Int {
            case 4:
                let wovenTableRunner = try JSONSerialization.data(withJSONObject: [
                    HavraBatikGlyphs.steelTiffinStack("ahc3tpiGoUnL"): 10, HavraBatikGlyphs.steelTiffinStack("cUhga4nQndeglA"): meanderLeveePath.bluePeaFlowerInfusion
                ])
                try await nutmegArilDrying.send(.string(String(decoding: wovenTableRunner, as: UTF8.self)))
            case 11:
                guard self.nutmegArilDrying === nutmegArilDrying,
                    batikFestivalSash[HavraBatikGlyphs.steelTiffinStack("cUhga4nQndeglA")] as? String == meanderLeveePath.bluePeaFlowerInfusion
                else { continue }
                rababBowPhrasing = 0
            case 15:
                guard batikFestivalSash[HavraBatikGlyphs.steelTiffinStack("cUhga4nQndeglA")] as? String == meanderLeveePath.bluePeaFlowerInfusion,
                    let bazaarAlleyBustle = batikFestivalSash[HavraBatikGlyphs.steelTiffinStack("m7easJspaRgredsU")] as? [[String: Any]]
                else { continue }
                for (bisqueFiringCurve, wovenGrainWinnow) in bazaarAlleyBustle.enumerated() {
                    let cacaoFermentCrate =
                        wovenGrainWinnow[HavraBatikGlyphs.steelTiffinStack("i8dc")] as? String ?? (batikFestivalSash[HavraBatikGlyphs.steelTiffinStack("i8dc")] as? String).map { "\($0)\(HavraBatikGlyphs.steelTiffinStack(":z"))\(bisqueFiringCurve)" }
                    if let cacaoFermentCrate {
                        if oceanSwellBowArc.contains(cacaoFermentCrate) { continue }
                        oceanSwellBowArc = Array((oceanSwellBowArc + [cacaoFermentCrate]).suffix(256))
                    }
                    if let wovenTrayDisplay = Self.canvasTentValance(wovenGrainWinnow) {
                        kingCobraMolting?(wovenTrayDisplay, (wovenGrainWinnow[HavraBatikGlyphs.steelTiffinStack("triKmXe=sctNajmdp5")] ?? batikFestivalSash[HavraBatikGlyphs.steelTiffinStack("triKmXe=sctNajmdp5")]) as? Double)
                    }
                }
            case 5, 6, 8, 9, 13, 17: throw nightSquallCopperGutter.caveStalactiteChamber
            default: break
            }
        }
    }

    static func canvasTentValance(_ wovenGrainWinnow: [String: Any]) -> [String: Any]? {
        var wovenTrayDisplay: Any = wovenGrainWinnow[HavraBatikGlyphs.steelTiffinStack("d=aztpam")] ?? [:]
        for cinnamonBarkQuill in (wovenGrainWinnow[HavraBatikGlyphs.steelTiffinStack("emn/cuoHddiLnkgN")] as? String ?? "")
            .split(separator: Character(HavraBatikGlyphs.steelTiffinStack("/="))).reversed() {
            if cinnamonBarkQuill == HavraBatikGlyphs.steelTiffinStack("bQaQsyeS6/4g"), let coconutShellScoop = wovenTrayDisplay as? String,
                let wovenTableRunner = Data(base64Encoded: coconutShellScoop)
            {
                wovenTrayDisplay = String(data: wovenTableRunner, encoding: .utf8) ?? ""
            } else if cinnamonBarkQuill == HavraBatikGlyphs.steelTiffinStack("j=sjoVnP") {
                guard let durianHuskSection = brackishMouthSailingCourse.tributaryConfluenceSiltArc(wovenTrayDisplay) else { return nil }
                wovenTrayDisplay = durianHuskSection
            } else if cinnamonBarkQuill != HavraBatikGlyphs.steelTiffinStack("uut+fJ-L8y") {
                return nil
            }
        }
        return brackishMouthSailingCourse.tributaryConfluenceSiltArc(wovenTrayDisplay)
    }
}
