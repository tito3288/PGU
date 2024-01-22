//
//  ContactView.swift
//  PGU
//
//  Created by Bryan Arambula on 1/22/24.
//

import SwiftUI

struct ContactView: View {
    
    @State private var isMenuOpen: Bool = false


    var body: some View {
        ZStack {
            // Image background
            Image("contact-us-pgu")
                .resizable()
                .scaledToFill() // Adjusts the image size while maintaining aspect ratio
                .frame(maxWidth: .infinity, maxHeight: .infinity) // Allows the image to expand
                .zIndex(0) // Lower zIndex so it stays in the background

            // Header
            VStack {
                HamburgerMenu(isMenuOpen: $isMenuOpen)
                    .padding(.top, 50)
                    .navigationBarBackButtonHidden(true)
                    .frame(height: 100)
                    .zIndex(1) // Higher zIndex ensures it's above the image

                Spacer() // This spacer pushes the footer to the bottom

                FooterMenu()
                    .padding(.bottom, 40)
                    .zIndex(1) // Same higher zIndex for the footer
            }

            // Side menu
            if isMenuOpen {
                MenuView(isMenuOpen: $isMenuOpen)
                    .frame(width: UIScreen.main.bounds.width)
                    .transition(.move(edge: .leading))
                    .zIndex(2) // Even higher zIndex to ensure it's above everything else
            }
        }
    }
}


#Preview {
    ContactView()
}
