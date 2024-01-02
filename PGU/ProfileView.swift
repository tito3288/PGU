//
//  ProfileView.swift
//  PGU
//
//  Created by Bryan Arambula on 12/4/23.
//

import SwiftUI

struct ProfileView: View {
    @State private var isMenuOpen: Bool = false
    
    @State private var showingLogoutAlert = false
    @State private var navigateToLogin = false


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
                            if item == "Terms and Condition" {
                                // Navigation link for "Terms and Condition"
                                NavigationLink(destination: TermsandCondView()) {
                                    HStack {
                                        Text(item)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(goldenColor)
                                    }
                                }
                                .padding()
                                .foregroundColor(.black)

                            }else if item == "FAQ"{
                                NavigationLink(destination: FaqView()) {
                                    HStack {
                                        Text(item)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(goldenColor)
                                    }
                                }
                                .padding()
                                .foregroundColor(.black)

                            }else if item == "Camp Information"{
                                NavigationLink(destination: CampInfoView()) {
                                    HStack {
                                        Text(item)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(goldenColor)
                                    }
                                }
                                .padding()
                                .foregroundColor(.black)
                                
                            }else if item == "Edit Profile"{
                                    NavigationLink(destination: EditProfileView()) {
                                        HStack {
                                            Text(item)
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(goldenColor)
                                        }
                                    }
                                    .padding()
                                    .foregroundColor(.black)

                                
                            } else if item == "Log Out" {
                                // Log Out item
                                Button(action: {
                                    self.showingLogoutAlert = true
                                }) {
                                    HStack {
                                        Text(item)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(goldenColor)
                                    }
                                }
                                .padding()
                                .foregroundColor(.black)
                                // Alert for Log Out Confirmation
                                .alert(isPresented: $showingLogoutAlert) {
                                    Alert(
                                        title: Text("Are you sure you want to log out?"),
                                        primaryButton: .destructive(Text("Log Out")) {
                                            self.navigateToLogin = true
                                        },
                                        secondaryButton: .cancel()
                                    )
                                }
                            }else {
                                // Regular items
                                HStack {
                                    Text(item)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(goldenColor)
                                }
                                .padding()
                            }
                            
                            NavigationLink(destination: LoginView(), isActive: $navigateToLogin) {
                                EmptyView()
                            }
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
