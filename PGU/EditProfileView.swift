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
                    TextField("Enter your name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        
                        print("Button for Week  tapped")
                    }) {
                        Image(systemName: "chevron.down") // Your button text
                            .frame(alignment: .trailing)
                            .padding(10)
                            .background(Color(hex: "c7972b"))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                }
                
                HStack {
                    Text("Username")
                    TextField("Enter your username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack {
                    Text("Password")
                    SecureField("Enter your password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack {
                    Text("Membership")
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