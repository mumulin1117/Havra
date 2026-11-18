// MorningMarketRhythm.swift
// Havra · B module

import UIKit
import UserNotifications

extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        NeighborhoodGameDay.velvetWonderTrail.velvetThoughtTrail(velvetFeelingTrail: deviceToken)
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        NeighborhoodGameDay.velvetWonderTrail.velvetExpressionTrail()
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        completionHandler(.noData)
    }
}
