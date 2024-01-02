//
//  ContentView.swift
//  PGU
//
//  Created by Bryan Arambula on 11/21/23.
//

import SwiftUI

struct ContentView: View {
    

    
    var body: some View {
        NavigationView {
            HomeView()
                .navigationBarBackButtonHidden(true)
            // Optionally hide the entire navigation bar if not needed
                .navigationBarHidden(true)
        }
        .accentColor(Color(hex: "c7972b"))
    }
    
}

#Preview {
    ContentView()
}
