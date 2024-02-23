//
//  ContentView.swift
//  PGU
//
//  Created by Bryan Arambula on 11/21/23.
//

import SwiftUI
import FirebaseAuth

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

    }
}

#Preview {
    ContentView()

}
