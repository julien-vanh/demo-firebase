//
//  NotificationManager.swift
//  DemoFirebase
//
//  Created by Julien Vanheule on 17/03/2024.
//

import SwiftUI

class NotificationManager {
    static func sendNotification() async {
        let content = UNMutableNotificationContent()
        content.title = "Bonjour"
        content.subtitle = "Ceci est une notif locale"
        content.sound = .defaultCritical
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3.0, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        do {
            try await UNUserNotificationCenter.current().add(request)
        } catch {
            print("Cannot send local notification")
        }
    }
}
