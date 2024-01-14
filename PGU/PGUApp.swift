//
//  PGUApp.swift
//  PGU
//
//  Created by Bryan Arambula on 11/21/23.
//

import SwiftUI
import FirebaseCore
import UserNotifications
import UIKit
import Firebase
import FirebaseFirestore
import FirebaseMessaging
import FirebaseAnalytics
import CoreData



@main
struct PGUApp: App {
    // Register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    let persistenceController = PersistenceController.shared


    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistenceController.persistentContainer.viewContext)        }
    }
}

// Define the AppDelegate class to configure Firebase
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        print("Application didFinishLaunchingWithOptions called")

        // Configure Firebase
        FirebaseApp.configure()
//        let db = Firestore.firestore()


        // Set up UNUserNotificationCenter
        UNUserNotificationCenter.current().delegate = self

        // Request notification authorization
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { granted, error in
                
                if let error = error {
                       print("Authorization request error: \(error)")
                   } else {
                       print("Authorization granted: \(granted)")
                   }
                // Handle the authorization request completion
            }
        )

        application.registerForRemoteNotifications()

        // Set up FIRMessaging's delegate
        Messaging.messaging().delegate = self
        
        
//        insertTestNotification()
     

        return true
     
    }
  

 
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        print("APNs device token retrieved: \(deviceToken)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications: \(error.localizedDescription)")
    }


    // MARK: MessagingDelegate methods
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("FCM Token received: \(fcmToken ?? "nil")")
      // Rest of your token handling code...
        
        if let token = fcmToken {
               saveTokenToFirestore(token)
           }
        
    }
    
    func saveTokenToFirestore(_ token: String) {
        // Assuming you have a `userId` to associate with the token
        let userId = "someUserId" // Replace with actual user ID
        let db = Firestore.firestore()
        db.collection("user_tokens").document(userId).setData(["fcmToken": token]) { error in
            if let error = error {
                print("Error saving token to Firestore: \(error)")
            } else {
                print("Token successfully saved to Firestore")
            }
        }
    }
    
    
 
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        if let notificationDict = userInfo["aps"] as? [String: AnyObject],
           let alertDict = notificationDict["alert"] as? [String: AnyObject],
           let title = alertDict["title"] as? String,
           let body = alertDict["body"] as? String {
            saveNotificationToCoreData(title: title, body: body)
        }
        completionHandler([.alert, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if let notificationDict = userInfo["aps"] as? [String: AnyObject],
           let alertDict = notificationDict["alert"] as? [String: AnyObject],
           let title = alertDict["title"] as? String,
           let body = alertDict["body"] as? String {
            saveNotificationToCoreData(title: title, body: body)
        }
        completionHandler()
    }

    

    
    // Add this method inside your AppDelegate
    func saveNotificationToCoreData(title: String, body: String) {
        let context = PersistenceController.shared.persistentContainer.viewContext
        let newNotification = Notifi(context: context)
        newNotification.title = title
        newNotification.body = body

        do {
            try context.save()
        } catch {
            print("Failed to save notification: \(error)")
        }
    }
    
    
    
        
    static func fetchFCMToken() {
           Messaging.messaging().token { token, error in
               if let error = error {
                   print("Error fetching FCM registration token: \(error)")
               } else if let token = token {
                   print("FCM registration token: \(token)")
                   // TODO: Send this token to your application server or use it as needed
               }
           }
       }

}


