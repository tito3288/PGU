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
import MapKit
import CoreLocation
import AVFoundation
import MediaPlayer


@main
struct PGUApp: App {
    // Register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let persistenceController = PersistenceController.shared
//    let navigationState = NavigationState() // The NavigationState instance
    
//    init() {
//        appDelegate.navigationState = navigationState // Initialize navigationState in AppDelegate
//    }

    let locationManager = CLLocationManager()
    
    init() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistenceController.persistentContainer.viewContext)
                .environmentObject(AudioPlayerManager.shared)
                .environmentObject(ViewState.shared) // Add this line to share ViewState across your views.


//                .environmentObject(navigationState) // Pass it as an EnvironmentObject

        }
    }
}



// Define the AppDelegate class to configure Firebase
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    


    //NOT SURE WHAT THIS CODE IF USED FOR ⬇️
    let gcmMessageIDKey = "gcm.message_id"



//    var navigationState: NavigationState?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        print("Application didFinishLaunchingWithOptions called")
        
        FirebaseApp.configure()

//        configureAudioSession()

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
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleInterruption), name: AVAudioSession.interruptionNotification, object: AVAudioSession.sharedInstance())

//        _ = AudioPlayerManager.shared

        
        return true
     
    }
    
    
//    class AudioPlayerManager {
//        static let shared = AudioPlayerManager() // Singleton instance
//        var player: AVPlayer?
//        
//        init() {
//            configureAudioSession()
//            configureRemoteCommandCenter()
//        }
//        
//        
//        private func configureAudioSession() {
//            do {
//                try AVAudioSession.sharedInstance().setCategory(.playback)
//                try AVAudioSession.sharedInstance().setActive(true)
//            } catch {
//                print("Failed to set audio session category: \(error)")
//            }
//            
//            
//        }
//        
//        
//        private func configureRemoteCommandCenter() {
//            let commandCenter = MPRemoteCommandCenter.shared()
//            
//            // Play command
//            commandCenter.playCommand.isEnabled = true
//            commandCenter.playCommand.addTarget { [weak self] event in
//                // Check if the player is available and resume playback
//                guard let self = self, let player = self.player else { return .commandFailed }
//                if player.rate == 0 {
//                    player.play()
//                    self.updateNowPlayingPlaybackRate(1.0)
//                }
//                return .success
//            }
//            
//            // Pause command
//            commandCenter.pauseCommand.isEnabled = true
//            commandCenter.pauseCommand.addTarget { [weak self] event in
//                // Check if the player is available and pause playback
//                guard let self = self, let player = self.player else { return .commandFailed }
//                if player.rate != 0 {
//                    player.pause()
//                    self.updateNowPlayingPlaybackRate(0.0)
//                }
//                return .success
//            }
//            
//            // Skip forward command
//            commandCenter.skipForwardCommand.isEnabled = true
//            commandCenter.skipForwardCommand.preferredIntervals = [15]  // 15 seconds
//            commandCenter.skipForwardCommand.addTarget { [weak self] event in
//                // Implement skipping forward
//                guard let self = self else { return .commandFailed }
//                self.skip(forwards: true)
//                return .success
//            }
//            
//            // Skip backward command
//            commandCenter.skipBackwardCommand.isEnabled = true
//            commandCenter.skipBackwardCommand.preferredIntervals = [15]  // 15 seconds
//            commandCenter.skipBackwardCommand.addTarget { [weak self] event in
//                // Implement skipping backward
//                guard let self = self else { return .commandFailed }
//                self.skip(forwards: false)
//                return .success
//            }
//        }
//
//        // Helper method to update the playback rate in the now playing info
//        private func updateNowPlayingPlaybackRate(_ rate: Float) {
//            var nowPlayingInfo = MPNowPlayingInfoCenter.default().nowPlayingInfo ?? [String: Any]()
//            nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = rate
//            MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
//        }
//
//        // Implement the skip method
//        private func skip(forwards: Bool) {
//            guard let player = player, let duration = player.currentItem?.duration.seconds else { return }
//            let currentTime = player.currentTime().seconds
//            let skipInterval = forwards ? 15.0 : -15.0  // 15 seconds
//            let newTime = currentTime + skipInterval
//            player.seek(to: CMTime(seconds: min(max(newTime, 0), duration), preferredTimescale: 1))
//        }
//
//        
//        
//        func play(url: URL) {
//            player = AVPlayer(url: url)
//            player?.play()
//        }
//        
//        func pause() {
//            player?.pause()
//        }
//        
//
//
//        
//    }

    

    
    @objc func handleInterruption(notification: Notification) {
        guard let info = notification.userInfo,
              let typeValue = info[AVAudioSessionInterruptionTypeKey] as? UInt,
              let type = AVAudioSession.InterruptionType(rawValue: typeValue) else {
                  return
              }

        if type == .began {
            // Interruption began, pause the audio
        } else if type == .ended {
            // Interruption ended, resume the audio
            try? AVAudioSession.sharedInstance().setActive(true)
            // Resume playback if necessary
        }
    }
    
    // Remember to remove the observer when it's no longer needed
    deinit {
        NotificationCenter.default.removeObserver(self, name: AVAudioSession.interruptionNotification, object: nil)
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


class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var lastLocation: CLLocation?
    @Published var userLocation: Location?


    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        print("Access to location granted successfully")
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Received location update: \(location.coordinate.latitude), \(location.coordinate.longitude)")
            self.userLocation = Location(title: "My Location", coordinate: location.coordinate, isUserLocation: true)
            self.lastLocation = location
        } else {
            print("Received location update but no location available")
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}




