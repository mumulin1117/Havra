import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        _ = application
        _ = launchOptions
        HavramarketFieldNote.kheneBambooTone.saungGaukCurve()
        return true
    }

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        _ = application
        _ = options
        let neonRainReflection = UISceneConfiguration(
            name: HavradrySeasonDustFishLife.vientianeRiverEdge,
            sessionRole: connectingSceneSession.role
        )
        neonRainReflection.delegateClass = HavraAtlasSceneKeeper.self
        return neonRainReflection
    }
}
