//
//  File.swift
//  PGU
//
//  Created by Bryan Arambula on 12/4/23.
//

import SwiftUI



struct FooterMenu: View {
    
    @Environment(\.managedObjectContext) var viewContext


    var body: some View {
 
        Divider()
        
        HStack {
            
            Spacer()

            NavigationLink(destination: ProfileView()){
                VStack{
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .frame(width: 25, height: 25)// Example icon
                    Text("Profile")
                        .foregroundColor(.gray)
                        .fontWeight(.bold)

                }
            }
             
                
            
            Spacer()
            
            NavigationLink(destination: InboxView()){
                VStack{
                    Image(systemName: "tray.full")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .frame(width: 25, height: 25)// Example icon
                    Text("Inbox")
                        .foregroundColor(.gray)
                        .fontWeight(.bold)

                }
            }
         
                
            
            Spacer()
            
//            Button(action: {
//                // Action for the third icon
//            }) {
            NavigationLink(destination: CampsView()){
                VStack{
                    Image(systemName: "mappin.and.ellipse")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .frame(width: 25, height: 25)// Example icon
                    Text("Camps")
                        .foregroundColor(.gray)
                        .fontWeight(.bold)

                }
            }
            
                
//            }
            
            Spacer()
            
            NavigationLink(destination: ResourcesView()){
                
                VStack{
                    Image(systemName: "basketball")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .frame(width: 25, height: 25)// Example icon
                    Text("Resources")
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                }
                
            }
            
            Spacer()

        }
        .padding(.top)
 
    }
    
  
//    func testSaveNotification() {
//        let context = PersistenceController.shared.persistentContainer.viewContext
//        let testNotification = Notifi(context: context)
//        testNotification.title = "Test Title"
//        testNotification.body = "This is a test notification body."
//
//        do {
//            try context.save()
//            print("Test notification saved successfully.")
//        } catch {
//            print("Failed to save test notification: \(error)")
//        }
//    }
//
//    
//    func sendTestLocalNotification() {
//        let content = UNMutableNotificationContent()
//        content.title = "Test Title"
//        content.body = "Test Body"
//        content.sound = UNNotificationSound.default
//
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//
//        UNUserNotificationCenter.current().add(request) { error in
//            if let error = error {
//                print("Error scheduling local notification: \(error)")
//            }
//        }
//    }

    
    
}

