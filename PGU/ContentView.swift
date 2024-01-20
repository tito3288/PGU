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
  

    var body: some View {
        NavigationView {
            if authViewModel.isAuthenticated {
                HomeView()
                    .navigationBarHidden(true)
            } else {
                LoginView()
                    .navigationBarHidden(true)
            }
        }
        .accentColor(Color(hex: "c7972b"))
    }
}

#Preview {
    ContentView()
}
