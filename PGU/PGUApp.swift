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
//    let navigationState = NavigationState() // The NavigationState instance
    
//    init() {
//        appDelegate.navigationState = navigationState // Initialize navigationState in AppDelegate
//    }



    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistenceController.persistentContainer.viewContext)
//                .environmentObject(navigationState) // Pass it as an EnvironmentObject

        }
    }
}


//extension AppDelegate {
//    func fetchAndHandleNotifications() {
//        let db = Firestore.firestore()
//        let userId = "yourUserId" // Replace with the actual user ID
//
//        db.collection("notifications").whereField("userId", isEqualTo: userId)
//            .getDocuments { (querySnapshot, err) in
//                if let err = err {
//                    print("Error getting notifications: \(err)")
//                } else {
//                    for document in querySnapshot!.documents {
//                        let data = document.data()
//                        if let title = data["title"] as? String, let body = data["body"] as? String {
//                            // Trigger a local notification or handle the data as needed
//                            self.triggerLocalNotification(title: title, body: body)
//                        }
//                    }
//                }
//            }
//    }
//
//    func triggerLocalNotification(title: String, body: String) {
//        let content = UNMutableNotificationContent()
//        content.title = title
//        content.body = body
//        content.sound = UNNotificationSound.default
//
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//
//        UNUserNotificationCenter.current().add(request) { error in
//            if let error = error {
//                print("Error scheduling local notification: \(error)")
//            }
//        }
//    }
//}


// Define the AppDelegate class to configure Firebase
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
//    func fetchAndHandleNotifications() {
//        let db = Firestore.firestore()
//        let userId = "yourUserId" // Replace with the actual user ID
//
//        db.collection("notifications").whereField("userId", isEqualTo: userId)
//            .getDocuments { (querySnapshot, err) in
//                if let err = err {
//                    print("Error getting notifications: \(err)")
//                } else {
//                    for document in querySnapshot!.documents {
//                        let data = document.data()
//                        if let title = data["title"] as? String, let body = data["body"] as? String {
//                            // Trigger a local notification or handle the data as needed
//                            self.triggerLocalNotification(title: title, body: body)
//                        }
//                    }
//                }
//            }
//    }
//    
//    func triggerLocalNotification(title: String, body: String) {
//        let content = UNMutableNotificationContent()
//        content.title = title
//        content.body = body
//        content.sound = UNNotificationSound.default
//
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//
//        UNUserNotificationCenter.current().add(request) { error in
//            if let error = error {
//                print("Error scheduling local notification: \(error)")
//            }
//        }
//    }

    //NOT SURE WHAT THIS CODE IF USED FOR ⬇️
    let gcmMessageIDKey = "gcm.message_id"



//    var navigationState: NavigationState?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        print("Application didFinishLaunchingWithOptions called")
        

        // Configure Firebase
        FirebaseApp.configure()
//        let db = Firestore.firestore()


        // Set up UNUserNotificationCenter
//        UNUserNotificationCenter.current().delegate = self

        // Request notification authorization
        let center = UNUserNotificationCenter.current()
         center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
             if let error = error {
                 print("Authorization request error: \(error)")
             } else {
                 print("Authorization granted: \(granted)")
                 if granted {
                     DispatchQueue.main.async {
                         application.registerForRemoteNotifications()
                     }
                 } else {
                     print("User denied notification permissions")
                     // Handle the denial of permissions here
                 }
             }
         }
         center.delegate = self

//        application.registerForRemoteNotifications()

        // Set up FIRMessaging's delegate
        Messaging.messaging().delegate = self
      
//        fetchAndHandleNotifications()

        return true
     
    }
  
    func applicationDidBecomeActive(_ application: UIApplication) {
//        fetchAndHandleNotifications()
    }
 
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        print("APNs device token retrieved: \(deviceToken)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications: \(error.localizedDescription)")
    }


    // MARK: LOGIC FOR RETREIVING THE FCM TOKEN AND PRINTING IT
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
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print("Received remote notification: \(userInfo)")
        completionHandler(.newData)


    }




    //MARK: LOGIC FOR SAVING THE FCM NOTIFICATION TO COREDATA
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
        
        saveNotificationToFirestore(userInfo)

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
        

        
        saveNotificationToFirestore(userInfo)

        completionHandler()
    }
    
    
    
    
    
//    func fetchNotificationsFromFirestore() {
//        let db = Firestore.firestore()
//        let userId = "yourUserId" // Replace with actual user ID
//
//        db.collection("notifications").whereField("userId", isEqualTo: userId)
//          .getDocuments { (querySnapshot, err) in
//              if let err = err {
//                  print("Error getting notifications: \(err)")
//              } else {
//                  for document in querySnapshot!.documents {
//                      // Assuming the document contains 'title' and 'body'
//                      let title = document.data()["title"] as? String ?? "No Title"
//                      let body = document.data()["body"] as? String ?? "No Body"
//                      self.triggerLocalNotification(title: title, body: body)
//                  }
//              }
//          }
//    }
    
    
    func saveNotificationToFirestore(_ userInfo: [AnyHashable: Any]) {
        guard let aps = userInfo["aps"] as? [String: AnyObject],
              let alert = aps["alert"] as? [String: String],
              let title = alert["title"],
              let body = alert["body"] else {
            print("Invalid notification content")
            return
        }

        let db = Firestore.firestore()
        let notificationData: [String: Any] = [
            "title": title,
            "body": body,
            "timestamp": FieldValue.serverTimestamp(),
            // You can add more fields if necessary
        ]
        
        // Save the notification in a separate 'notifications' collection
        db.collection("notifications").addDocument(data: notificationData) { error in
            if let error = error {
                print("Error saving notification to Firestore: \(error)")
            } else {
                print("Notification successfully saved to Firestore")
            }
        }
        
//        triggerLocalNotification(title: title, body: body)

    }


    
    
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
        
        printAllNotifications()
    }
    
    
    func printAllNotifications() {
        let context = PersistenceController.shared.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Notifi> = Notifi.fetchRequest()

        do {
            let notifications = try context.fetch(fetchRequest)
            for notification in notifications {
                print("Title: \(notification.title ?? "Unknown Title"), Body: \(notification.body ?? "No Body")")
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }


    


}




