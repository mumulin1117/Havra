import UIKit

class HavraAtlasSceneKeeper: UIResponder, UIWindowSceneDelegate {
    var atlasWindow: UIWindow?

    func scene(
        _ atlasScene: UIScene,
        willConnectTo atlasSession: UISceneSession,
        options launchRouteOptions: UIScene.ConnectionOptions
    ) {
        _ = atlasSession
        _ = launchRouteOptions
        guard let atlasWindowScene = atlasScene as? UIWindowScene else { return }

        let atlasWindow = UIWindow(windowScene: atlasWindowScene)
        atlasWindow.backgroundColor = UIColor(red: 0.0, green: 0.07, blue: 0.06, alpha: 1.0)
        atlasWindow.rootViewController = HavraShellJaonController()
        self.atlasWindow = atlasWindow
        atlasWindow.makeKeyAndVisible()
    }
}
