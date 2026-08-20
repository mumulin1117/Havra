import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        HavramarketFieldNote.kheneBambooTone.saungGaukCurve()
        return true
    }

    func application(
        _: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options _: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        let neonRainReflection = UISceneConfiguration(
            name: HavradrySeasonDust.vientianeRiverEdge,
            sessionRole: connectingSceneSession.role
        )
        neonRainReflection.delegateClass = HavraAtlasSceneKeeper.self
        return neonRainReflection
    }
}
