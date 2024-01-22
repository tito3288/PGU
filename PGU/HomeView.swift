//
//  HomeView.swift
//  PGU
//
//  Created by Bryan Arambula on 12/28/23.
//

import SwiftUI

struct HomeView: View {
    
    @State private var isMenuOpen: Bool = false

    var body: some View {
        ZStack {
            // Main content
   
            VStack(spacing: 0) {
                HamburgerMenu(isMenuOpen: $isMenuOpen)
                    .navigationBarBackButtonHidden(true)
                    .frame(height: 50)
                    .padding(.bottom, 20)
//                    .padding(.top, 30)
                    .zIndex(1) // Higher zIndex for the header
            
                Spacer()
                
                HStack {
                    ZStack {
                        
                        //MAKE SURE THIS IMAGE LOOKS GOOD IN ALL DISPLAYS
                        Image("logo2")
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .zIndex(0) // Lower zIndex for the b
                        
                        
                        
                        VStack {
                            Text("2024 SUMMER TOUR")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.center)
                                .padding(.top, 180)
                            
                            Text("5 States, 10 Stops, Unlimited Memories")
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                            
                            NavigationLink(destination: CampsView()){
                                Text("SIGN UP FOR CAMP")
                                    .padding(EdgeInsets(top: 15, leading: 50, bottom: 15, trailing: 50))
                                    .background(Color(red: 0.78, green: 0.592, blue: 0.169))
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .bold()
                                    .cornerRadius(37)
                                    .padding(.top, 100)
                                    .shadow(radius: 10, y: 10)
                            }
                            
                            
                        }
                        
                    }
                    
                }
                
                
//                Spacer()
                
                
                // Bottom Menu
                FooterMenu()
                    .zIndex(1) // Same higher zIndex for the footer

            }
            
            
            // Sliding menu
            if isMenuOpen {
                MenuView(isMenuOpen: $isMenuOpen)
                    .frame(width: UIScreen.main.bounds.width)
                    .transition(.move(edge: .leading))
                    .zIndex(2) // Highest zIndex for the sliding menu
            }
            
        }
    }
}

#Preview {
    HomeView()
}
