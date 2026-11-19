import UIKit
import UserNotifications

extension AppDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let sanctumArchPassage = deviceToken.map { String(format: "%02x", $0) }.joined()
        UserDefaults.standard.set(sanctumArchPassage, forKey: brackishMouthSailingCourse.jackfruitArilCluster)
    }
}
