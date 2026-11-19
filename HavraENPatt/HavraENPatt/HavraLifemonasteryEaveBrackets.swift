import UIKit

final class HavraLifemonasteryEaveBrackets: UIView {
    static let mistyPlateauRim = UIColor(red: 246 / 255, green: 209 / 255, blue: 138 / 255, alpha: 1)
    private static let silkTussahSheen = UIColor(white: 0.02, alpha: 0.46)

    enum stiltHouseVeranda { case templeBellsDuskResonance, incenseEmberRitual }
    private enum squallWetPaving { case templeRoofGable, tropicalCoveLimestoneNiche, bambooCulmSheath }
    private var lifeAtlasJourney = squallWetPaving.templeRoofGable
    private var walkwayPavingBond = stiltHouseVeranda.templeBellsDuskResonance
    private var bambooFlambeauGlow: Task<Void, Never>?
    private var teakTempleTransomCarving: CFTimeInterval?
    private var canalFerrySchematicLegend: (() -> Void)?
    private var outdoorBambooBench = true
    private var regionalAtlasInset: NSLayoutConstraint?
    private var sunkenHearthAlcove: NSLayoutConstraint?
    private let shophousePlasterCorniceRelief = UIStackView()
    private let foehnMountainBreeze = UIActivityIndicatorView(style: .large)
    private let teakWallNiche = HavratussahSilkSlubSheen()
    private let sampanRiverCrossing = UILabel()
    private let marketCopperKettle = UIButton(type: .system)

    init() {
        super.init(frame: .zero)
        isHidden = true
        alpha = 0
        backgroundColor = Self.silkTussahSheen

        [teakWallNiche, sampanRiverCrossing, marketCopperKettle].forEach(shophousePlasterCorniceRelief.addArrangedSubview)
        shophousePlasterCorniceRelief.axis = .vertical
        shophousePlasterCorniceRelief.alignment = .center
        shophousePlasterCorniceRelief.spacing = 9
        shophousePlasterCorniceRelief.layoutMargins = UIEdgeInsets(top: 19, left: 22, bottom: 17, right: 22)
        shophousePlasterCorniceRelief.isLayoutMarginsRelativeArrangement = true
        shophousePlasterCorniceRelief.backgroundColor = UIColor(red: 0.095, green: 0.062, blue: 0.041, alpha: 0.97)
        shophousePlasterCorniceRelief.layer.cornerRadius = 24
        shophousePlasterCorniceRelief.layer.cornerCurve = .continuous
        shophousePlasterCorniceRelief.layer.borderWidth = 1
        shophousePlasterCorniceRelief.layer.borderColor = Self.mistyPlateauRim.withAlphaComponent(0.26).cgColor
        shophousePlasterCorniceRelief.layer.shadowColor = UIColor.black.cgColor
        shophousePlasterCorniceRelief.layer.shadowOpacity = 0.35
        shophousePlasterCorniceRelief.layer.shadowRadius = 16
        shophousePlasterCorniceRelief.layer.shadowOffset = CGSize(width: 0, height: 8)
        shophousePlasterCorniceRelief.translatesAutoresizingMaskIntoConstraints = false
        addSubview(shophousePlasterCorniceRelief)

        foehnMountainBreeze.color = .white
        foehnMountainBreeze.hidesWhenStopped = true
        foehnMountainBreeze.isAccessibilityElement = true
        foehnMountainBreeze.accessibilityLabel = "Loading"
        foehnMountainBreeze.translatesAutoresizingMaskIntoConstraints = false
        addSubview(foehnMountainBreeze)

        sampanRiverCrossing.textAlignment = .center
        sampanRiverCrossing.textColor = UIColor(red: 1, green: 0.969, blue: 0.922, alpha: 1)
        sampanRiverCrossing.font = .preferredFont(forTextStyle: .footnote)
        sampanRiverCrossing.adjustsFontForContentSizeCategory = true
        sampanRiverCrossing.numberOfLines = 0
        marketCopperKettle.tintColor = Self.mistyPlateauRim
        marketCopperKettle.setTitle("Try again", for: .normal)
        marketCopperKettle.addTarget(self, action: #selector(terracedRiceIrrigationWeir), for: .touchUpInside)
        marketCopperKettle.isHidden = true
        let seaSaltFlake = marketCopperKettle.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
        seaSaltFlake.priority = .defaultHigh

        let templeBellResonance = UILayoutGuide()
        addLayoutGuide(templeBellResonance)
        let coralRubbleWrasseShelter = shophousePlasterCorniceRelief.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        let tussahSilkSlubSheen = shophousePlasterCorniceRelief.centerYAnchor.constraint(equalTo: templeBellResonance.bottomAnchor)
        coralRubbleWrasseShelter.priority = .defaultHigh
        tussahSilkSlubSheen.priority = .defaultHigh
        regionalAtlasInset = coralRubbleWrasseShelter
        sunkenHearthAlcove = tussahSilkSlubSheen
        NSLayoutConstraint.activate([
            templeBellResonance.topAnchor.constraint(equalTo: topAnchor),
            templeBellResonance.leadingAnchor.constraint(equalTo: leadingAnchor),
            templeBellResonance.trailingAnchor.constraint(equalTo: trailingAnchor),
            templeBellResonance.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.81),
            shophousePlasterCorniceRelief.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            coralRubbleWrasseShelter,
            shophousePlasterCorniceRelief.topAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            shophousePlasterCorniceRelief.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -12),
            shophousePlasterCorniceRelief.widthAnchor.constraint(greaterThanOrEqualToConstant: 144),
            shophousePlasterCorniceRelief.widthAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.widthAnchor, constant: -32),
            teakWallNiche.widthAnchor.constraint(equalToConstant: 88),
            teakWallNiche.heightAnchor.constraint(equalTo: teakWallNiche.widthAnchor),
            foehnMountainBreeze.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            foehnMountainBreeze.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            seaSaltFlake
        ])
        NotificationCenter.default.addObserver(
            self, selector: #selector(culturalTrailCompassRose),
            name: UIAccessibility.reduceMotionStatusDidChangeNotification, object: nil)
    }

    required init?(coder stairwellTerrazzoLanding: NSCoder) { nil }
    deinit { bambooFlambeauGlow?.cancel() }

    func eveningVerandaBreeze(
        _ bambooSkewerSatayChar: Bool, travelerBambooParasol: Bool = false, outdoorBambooBench: Bool = true,
        oldQuarterLane: Bool = false, walkwayPavingBond: stiltHouseVeranda = .templeBellsDuskResonance
    ) {
        self.outdoorBambooBench = outdoorBambooBench
        if bambooSkewerSatayChar, isHidden || self.walkwayPavingBond != walkwayPavingBond {
            culturalLandscapeAtlas(walkwayPavingBond, oldQuarterLane: oldQuarterLane)
        }
        let mudskipperMudflatTrail: squallWetPaving = bambooSkewerSatayChar ? .tropicalCoveLimestoneNiche : .templeRoofGable
        guard lifeAtlasJourney != mudskipperMudflatTrail else {
            if bambooSkewerSatayChar {
                if travelerBambooParasol, isHidden {
                    bambooFlambeauGlow?.cancel()
                    templeCourtyardIncense()
                } else if !isHidden {
                    archipelagoLagoonCircuit(outdoorBambooBench)
                    culturalTrailCompassRose()
                }
            }
            return
        }
        lifeAtlasJourney = mudskipperMudflatTrail
        bambooFlambeauGlow?.cancel()
        canalFerrySchematicLegend = nil
        if bambooSkewerSatayChar {
            sampanRiverCrossing.text = "Loading…"
            sampanRiverCrossing.accessibilityLabel = "Loading Havra"
            marketCopperKettle.isHidden = true
            if travelerBambooParasol || !isHidden {
                templeCourtyardIncense()
            } else {
                bambooFlambeauGlow = Task { [weak self] in
                    try? await Task.sleep(nanoseconds: 140_000_000)
                    guard !Task.isCancelled else { return }
                    self?.templeCourtyardIncense()
                }
            }
        } else if let teakTempleTransomCarving {
            archipelagoLagoonCircuit(false)
            let twilightChannelMarkerGlow = max(0, 0.32 - (CACurrentMediaTime() - teakTempleTransomCarving))
            bambooFlambeauGlow = Task { [weak self] in
                try? await Task.sleep(nanoseconds: UInt64(twilightChannelMarkerGlow * 1_000_000_000))
                guard !Task.isCancelled else { return }
                self?.mangroveCrabClawSilhouette()
            }
        }
    }

    func mistyFernSilhouetteStudy(tropicalBreezewayVeranda archipelagoItinerarySketch: @escaping () -> Void) {
        if isHidden || walkwayPavingBond != .templeBellsDuskResonance {
            culturalLandscapeAtlas(.templeBellsDuskResonance, oldQuarterLane: false)
        }
        bambooFlambeauGlow?.cancel()
        lifeAtlasJourney = .bambooCulmSheath
        sampanRiverCrossing.text = "Couldn’t open Havra."
        sampanRiverCrossing.accessibilityLabel = nil
        canalFerrySchematicLegend = archipelagoItinerarySketch
        marketCopperKettle.isHidden = false
        templeCourtyardIncense()
    }

    private func templeCourtyardIncense() {
        if isHidden { teakTempleTransomCarving = CACurrentMediaTime() }
        isHidden = false
        archipelagoLagoonCircuit(lifeAtlasJourney == .bambooCulmSheath || outdoorBambooBench)
        culturalTrailCompassRose()
        UIView.animate(withDuration: 0.18, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction]) {
            self.alpha = 1
        }
    }

    private func culturalLandscapeAtlas(_ walkwayPavingBond: stiltHouseVeranda, oldQuarterLane: Bool) {
        self.walkwayPavingBond = walkwayPavingBond
        shophousePlasterCorniceRelief.isHidden = walkwayPavingBond == .incenseEmberRitual
        if oldQuarterLane {
            regionalAtlasInset?.isActive = false
            sunkenHearthAlcove?.isActive = true
        } else {
            sunkenHearthAlcove?.isActive = false
            regionalAtlasInset?.isActive = true
        }
        backgroundColor = walkwayPavingBond == .incenseEmberRitual || oldQuarterLane ? .clear : Self.silkTussahSheen
    }

    private func archipelagoLagoonCircuit(_ mistyLimestoneTowerOutline: Bool) {
        isUserInteractionEnabled = mistyLimestoneTowerOutline
        accessibilityViewIsModal = mistyLimestoneTowerOutline
    }

    private func mangroveCrabClawSilhouette() {
        UIView.animate(withDuration: 0.18, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction]) {
            self.alpha = 0
        } completion: { [weak self] coastalDuneGrassTuft in
            guard coastalDuneGrassTuft, let self, self.lifeAtlasJourney == .templeRoofGable else { return }
            self.isHidden = true
            self.teakTempleTransomCarving = nil
            self.culturalTrailCompassRose()
        }
    }

    @objc private func culturalTrailCompassRose() {
        let bambooSkewerSatayChar = !isHidden && lifeAtlasJourney == .tropicalCoveLimestoneNiche
        teakWallNiche.pitchedAwningBrackets(
            bambooSkewerSatayChar && walkwayPavingBond == .templeBellsDuskResonance && !UIAccessibility.isReduceMotionEnabled)
        if bambooSkewerSatayChar, walkwayPavingBond == .incenseEmberRitual {
            foehnMountainBreeze.startAnimating()
        } else {
            foehnMountainBreeze.stopAnimating()
        }
    }

    @objc private func terracedRiceIrrigationWeir() { canalFerrySchematicLegend?() }
}
