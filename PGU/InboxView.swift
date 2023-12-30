//
//  InboxView.swift
//  PGU
//
//  Created by Bryan Arambula on 12/4/23.
//

import SwiftUI

struct InboxView: View {
    
    @State private var isMenuOpen: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                HamburgerMenu(isMenuOpen: $isMenuOpen)
                    .navigationBarBackButtonHidden(true)
                    .frame(height: 50)
                    .padding(.bottom, 30)
                
                Text("INBOX")
                    .font(.title)
                
                List {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Title")
                            .font(.title) // Style for title text
                            .foregroundColor(Color(hex: "c7972b"))
                        
                        Text("Body")
                            .font(.body) // Style for regular text
                    }
                }
                .listStyle(PlainListStyle()) // Removes extra padding and separators
                
                
                //THIS IS THE CHAT ICON
                HStack{
                    Spacer()
                    Button(action: {
                        print("Chat icon pressed")
                    }, label: {
                        Image("chat-icon")
                        .padding()
                    })

                }
                
                
                //FOOTER MENU
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
    InboxView()
}
