//
//  FinewasteApp.swift
//  Finewaste
//
//  Created by charlie siagian on 26/10/21.
//

import SwiftUI
import Firebase
import UserNotifications
import FirebaseMessaging

class AppDelegate: NSObject, UIApplicationDelegate, MessagingDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        self.setupRemoteNotifications(for: application)
        
        Messaging.messaging().delegate = self
        Messaging.messaging().token { token, error in
            if let error = error {
                print("FinewasteDebug Error fetching FCM registration token: \(error)")
            } else if let token = token {
                print("FinewasteDebug FCM registration token: \(token)")
            }
        }
        
        return true
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("FinewasteDebug Firebase FCM DidReceive token: \(String(describing: fcmToken))")
        
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
        )
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    private func setupRemoteNotifications(for application: UIApplication) {
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
        
        application.registerForRemoteNotifications()
    }
}

@main
struct FinewasteApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .foregroundColor(Colors.DarkGray)
        }
    }
}
