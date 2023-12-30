//
//  File.swift
//  PGU
//
//  Created by Bryan Arambula on 12/4/23.
//

import SwiftUI

enum CurrentView {
    case profile, inbox, camps, workout
}

struct FooterMenu: View {
    
    @State private var currentView: CurrentView = .profile // Default to profile view

    
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
                }
            }
            
                
//            }
            
            Spacer()
            
            Button(action: {
                // Action for the fourth icon
            }) {
                VStack{
                    Image(systemName: "airplane")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .frame(width: 25, height: 25)// Example icon
                    Text("Workout")
                        .foregroundColor(.gray)
                }
                
            }
            
            Spacer()

        }
        
        
    }
}

