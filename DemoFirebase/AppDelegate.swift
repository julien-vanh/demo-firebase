//
//  AppDelegate.swift
//  DemoFirebase
//
//  Created by Julien Vanheule on 05.02.2024.
//

import SwiftUI
import FirebaseCore
import UserNotifications
import FirebaseMessaging


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    Messaging.messaging().delegate = self

    let notificationCenter = UNUserNotificationCenter.current()
    notificationCenter.delegate = self
    let authOptions: UNAuthorizationOptions = [.badge, .alert, .sound]
    notificationCenter.requestAuthorization(options: authOptions) { granted, error in
        if let error = error {
            print(error)
        }
    }
    application.registerForRemoteNotifications()
    return true
  }
}


extension AppDelegate: UNUserNotificationCenterDelegate {
    // Permet de faire apparaitre la notification lorsque l'app est ouverte en foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        [[.banner, .badge, .sound]]
    }
}

extension AppDelegate: MessagingDelegate {
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenArray = deviceToken.map {data in String(format: "%02.2hhx, data")}
        let tokenString = tokenArray.joined()
        print("APN device token : \(tokenString)")
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("FCM device token : \(String(describing: fcmToken))")
    }
}
