//
//  ContentView.swift
//  PGU
//
//  Created by Bryan Arambula on 11/21/23.
//

import SwiftUI
import FirebaseAuth
import AppTrackingTransparency  // Ensure you import AppTrackingTransparency


struct ContentView: View {
    @StateObject var authViewModel = AuthenticationViewModel()
    @EnvironmentObject var navigationState: NavigationState  // Add this line


    var body: some View {
        NavigationView {
            if authViewModel.isAuthenticated {
                if navigationState.showInbox {  // Check if should navigate to Inbox
                    InboxView()
                        .navigationBarHidden(true)
                } else {
                    HomeView()
                        .navigationBarHidden(true)
                }
            } else {
                LoginView()
                    .navigationBarHidden(true)
            }
        }  
        .accentColor(Color(hex: "c7972b"))
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            // Request App Tracking Transparency permission when the view appears
            requestTrackingPermission()
        }


    }
    
    private func requestTrackingPermission() {
        // Check if the ATT request can be made (iOS 14 and above)
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    // Tracking authorization granted
                    print("Tracking authorized by the user")
                case .denied, .restricted, .notDetermined:
                    // Tracking authorization denied, restricted, or not determined
                    print("Tracking not authorized or undecided")
                @unknown default:
                    break
                }
            }
        } else {
            // Handle earlier iOS versions if necessary, where ATT is not applicable
            print("App Tracking Transparency not available")
        }
    }
}

#Preview {
    ContentView()

}
