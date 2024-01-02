//
//  InboxView.swift
//  PGU
//
//  Created by Bryan Arambula on 12/4/23.
//

import SwiftUI

struct InboxView: View {
    
    @State private var isMenuOpen: Bool = false
    
    @State private var messages = ["Title1", "Title2", "Title3"]
 
    var body: some View {
        ZStack {
            VStack {
                HamburgerMenu(isMenuOpen: $isMenuOpen)
                    .navigationBarBackButtonHidden(true)
                    .frame(height: 50)
                    .padding(.bottom, 30)
                
                Text("INBOX")
                    .font(.title)
                    .fontWeight(.bold)
                
                List {
                    ForEach(messages, id: \.self) { message in
                        VStack(alignment: .leading, spacing: 0) {
                            Text(message)
                                .font(.title2)
                                .foregroundColor(Color(hex: "c7972b"))
                                .fontWeight(.bold)
                            
                            Text("Body for \(message)")
                                .font(.body)
                        }
                    }
                    .onDelete(perform: deleteMessage)
                }
                .listStyle(PlainListStyle())
                
                
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
    
    func deleteMessage(at offsets: IndexSet) {
            messages.remove(atOffsets: offsets)
        }
    
}

#Preview {
    InboxView()
}
