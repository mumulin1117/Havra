import UIKit

class HavraAtlasSceneKeeper: UIResponder, UIWindowSceneDelegate {
    var islandFieldNoteWindow: UIWindow?

    func scene(
        _ atlasScene: UIScene,
        willConnectTo _: UISceneSession,
        options _: UIScene.ConnectionOptions
    ) {
        guard let atlasWindowScene = atlasScene as? UIWindowScene else { return }

        let afabricPatternAtlasWindow = UIWindow(windowScene: atlasWindowScene)
        afabricPatternAtlasWindow.backgroundColor = UIColor(red: 0.0, green: 0.07, blue: 0.06, alpha: 1.0)
        afabricPatternAtlasWindow.rootViewController = HavraShellJaonController()
        self.islandFieldNoteWindow = afabricPatternAtlasWindow
        afabricPatternAtlasWindow.makeKeyAndVisible()
    }
}
