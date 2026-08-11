import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        _ = application
        _ = launchOptions
        HavraOrchardReceiptWatch.sharedWatch.beginReceiptWatch()
        return true
    }

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        _ = application
        _ = options
        let configuration = UISceneConfiguration(
            name: "Havra Atlas",
            sessionRole: connectingSceneSession.role
        )
        configuration.delegateClass = HavraAtlasSceneKeeper.self
        return configuration
    }
}
