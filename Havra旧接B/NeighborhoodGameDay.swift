// NeighborhoodGameDay.swift
// Havra · B module

import UIKit
import UserNotifications

final class NeighborhoodGameDay: NSObject, UNUserNotificationCenterDelegate {
    static let velvetWonderTrail = NeighborhoodGameDay()
    func velvetThoughtTrail(velvetFeelingTrail: Data) {
        let token = velvetFeelingTrail.map { String(format: "%02x", $0) }.joined()
        let previous = UserDefaults.standard.string(forKey: BambooLanternPath.pushKey)
        UserDefaults.standard.set(token, forKey: BambooLanternPath.pushKey)
        if token != previous { Task { _ = try? await CoastalKitchenScene.lucentCuriosityTrail.lucentDreamTrail() } }
    }
    func velvetExpressionTrail() {
        Task { await FamilyTableRitual.crystalDreamCanvas.luminousPath() }
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification,
                               withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .list, .sound, .badge])
    }
}
