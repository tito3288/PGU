//
//  EditProfileView.swift
//  PGU
//
//  Created by Bryan Arambula on 12/31/23.
//

import SwiftUI

struct EditProfileView: View {
    
    @State private var name: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var membership: String = ""
    
    var body: some View {
        
        Image("logo").resizable().scaledToFit().frame(width: 240, height: 90)
        
        Spacer()
        
        VStack{
            
            Text("EDIT PROFILE")
                .padding()
                .font(.title)
                .fontWeight(.bold)
            
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 90)
                .padding(30)
                .foregroundColor(.white)
                .background(Circle().fill(Color(hex: "c7972b")))
                .clipShape(Circle())
                .overlay(Circle().stroke(Color(hex: "c7972b"), lineWidth: 2))
            
            Text("Edit Photo")
                .foregroundColor(.gray)
            
            Group {
                HStack {
                    Text("Name")
                        .frame(width: 110, alignment: .leading) // Fixed width
                        .fontWeight(.bold)

                    TextField("Enter your name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                  
                }
                
                HStack {
                    Text("Username")
                        .frame(width: 110, alignment: .leading) // Fixed width
                        .fontWeight(.bold)

                    TextField("Enter your username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack {
                    
                    Text("Password")
                        .frame(width: 110, alignment: .leading) // Fixed width
                        .fontWeight(.bold)

                    SecureField("Enter your password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack {
                    Text("Membership")
                        .frame(width: 110, alignment: .leading) // Fixed width
                        .fontWeight(.bold)

                    TextField("Enter your membership type", text: $membership)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            .padding()
            
        }
        
        Spacer()
        
        FooterMenu()

        
    }
    
}

#Preview {
    EditProfileView()
}
