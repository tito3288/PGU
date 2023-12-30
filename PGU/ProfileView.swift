//
//  ProfileView.swift
//  PGU
//
//  Created by Bryan Arambula on 12/4/23.
//

import SwiftUI

struct ProfileView: View {
    @State private var isMenuOpen: Bool = false
    
    var body: some View {
        
        ZStack {
            // Combined Main content and List in a single VStack
            VStack(spacing: 0) {
                HamburgerMenu(isMenuOpen: $isMenuOpen)
                    .navigationBarBackButtonHidden(true)
                    .frame(height: 50)
                    .padding(.bottom, 30)
                
                let goldenColor = Color(red: 0.85, green: 0.65, blue: 0.13)
                
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .padding(30)
                    .foregroundColor(.white)
                    .background(Circle().fill(goldenColor))
                    .clipShape(Circle())
                    .overlay(Circle().stroke(goldenColor, lineWidth: 2))
                
                Text("Name")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                
                Text("Email Address")
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                
                ScrollView {
                    VStack {
                        ForEach(["Edit Profile", "Membership", "Camp Information", "Terms and Condition", "Contact Us", "FAQ", "Log Out"], id: \.self) { item in
                            HStack {
                                Text(item)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(goldenColor)
                            }
                            .padding()
                        }
                    }
                }
                
                FooterMenu()
            }
            
            // Sliding menu
            if isMenuOpen {
                MenuView(isMenuOpen: $isMenuOpen)
                    .frame(width: UIScreen.main.bounds.width)
                    .transition(.move(edge: .leading))
                    .zIndex(1) // Ensure the menu is on top
            }
        }
        
    }
}

#Preview {
    ProfileView()
}
