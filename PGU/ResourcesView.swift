//
//  ResourcesView.swift
//  PGU
//
//  Created by Bryan Arambula on 1/3/24.
//

import SwiftUI

struct ResourcesView: View {
    
    @State private var isMenuOpen: Bool = false

    var body: some View {
        
        ZStack{
            VStack{
                //THE HAMBURGER MENU NEEDS TO BE AFTER THE VSTACK IN ORDER FOR THE MENU VIEW TO COVER THE ENTIRE VIEW WHEN THE HAMBURGER MENU GETS CLICKED ⬇️
                HamburgerMenu(isMenuOpen: $isMenuOpen)
                    .navigationBarBackButtonHidden(true)
                    .frame(height: 50)
                    .padding(.bottom, 30)
                
                Spacer()
                
                
                HStack{
                    
                    Text("Podcast")
                        .padding(10)
                        .background(Color(hex: "c7972b"))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    
                    Text("Coach Drills")
                        .padding(10)
                        .background(Color(hex: "0f2d53"))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    NavigationLink(destination: CampInfoView()){
                        Text("Film Review")
                            .padding(10)
                            .background(Color(hex: "0f2d53"))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    
                }
                .padding()
                
                
                Image("podcast-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                
                List{
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Episode 4: Podcast Name")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: "0f2d53"))// Style for regular text
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Your button action here
                            print("Sign Up pressed")
                        }) {
                            Image(systemName: "play.fill") // Your button text
                                .frame(alignment: .trailing)
                                .padding(10)
                                .background(Color(hex: "c7972b"))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                    }
                    
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Episode 3: Podcast Name")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: "0f2d53"))// Style for regular text
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Your button action here
                            print("Sign Up pressed")
                        }) {
                            Image(systemName: "play.fill") // Your button text
                                .frame(alignment: .trailing)
                                .padding(10)
                                .background(Color(hex: "c7972b"))
                                .foregroundColor(.white)
                                .cornerRadius(20)

                        }
                        
                    }
                    
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Episode 2: Podcast Name")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: "0f2d53"))// Style for regular text
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Your button action here
                            print("Sign Up pressed")
                        }) {
                            Image(systemName: "play.fill") // Your button text
                                .frame(alignment: .trailing)
                                .padding(10)
                                .background(Color(hex: "c7972b"))
                                .foregroundColor(.white)
                                .cornerRadius(20)

                        }
                    }
                    
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Epospde 1: Podcast Name")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: "0f2d53"))// Style for regular text
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Your button action here
                            print("Sign Up pressed")
                        }) {
                            Image(systemName: "play.fill") // Your button text
                                .frame(alignment: .trailing)
                                .padding(10)
                                .background(Color(hex: "c7972b"))
                                .foregroundColor(.white)
                                .cornerRadius(20)

                        }
                        
                    }
                    
                }
                .listStyle(PlainListStyle()) // Removes extra padding and separators in iOS 14+
                
                FooterMenu()
                
            }
            if isMenuOpen {
                MenuView(isMenuOpen: $isMenuOpen)
                    .frame(width: UIScreen.main.bounds.width)
                    .transition(.move(edge: .leading))
            }
        }
        .navigationBarBackButtonHidden(true)    }
}

#Preview {
    ResourcesView()
}
