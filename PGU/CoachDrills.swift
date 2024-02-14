//
//  CoachDrills.swift
//  PGU
//
//  Created by Bryan Arambula on 2/12/24.
//

import SwiftUI
import SwiftUI
import UIKit
import ImageIO


struct CoachDrills: View {
    
    @State private var isMenuOpen: Bool = false

    var body: some View {
        ZStack {
            VStack {
                HamburgerMenu(isMenuOpen: $isMenuOpen)
                    .navigationBarBackButtonHidden(true)
                    .frame(height: 50)
                    .padding(.bottom, 30)
                
                HStack {
                    NavigationLink(destination: ResourcesView()) {
                        Text("Podcast")
                            .padding(10)
                            .frame(minWidth: 0, maxWidth: .infinity) // Flexible frame
                            .background(Color(hex: "0f2d53"))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    
                    Spacer() // Spacing between buttons
                    

                        Text("Coach Drills")
                            .padding(10)
                            .frame(minWidth: 0, maxWidth: .infinity) // Flexible frame
                            .background(Color(hex: "c7972b"))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    Spacer() // Spacing between buttons
                    NavigationLink(destination: FilmReviewView()) {
                    Text("Rob's Clips")
                        .padding(10)
                        .frame(minWidth: 0, maxWidth: .infinity) // Flexible frame
                        .background(Color(hex: "0f2d53"))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    
                }
                .padding()

                Spacer() // Pushes everything above towards the top

                Image("coach-drills5")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 350)

                Spacer() // Creates space between the image and the footer

                FooterMenu()
                    .zIndex(1) // Ensures the footer is above other elements if needed
            }

            if isMenuOpen {
                MenuView(isMenuOpen: $isMenuOpen)
                    .frame(width: UIScreen.main.bounds.width)
                    .transition(.move(edge: .leading))
                    .zIndex(2) // Ensures the menu is above everything else
            }
        }
    }
}


#Preview {
    CoachDrills()
}
