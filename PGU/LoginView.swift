//
//  SignupandLoginView.swift
//  PGU
//
//  Created by Bryan Arambula on 12/30/23.
//

import SwiftUI

struct LoginView: View {
    
    @State private var searchText1 = "" // State variable to hold search text
    @State private var searchText2 = "" // State variable to hold search text

    
    var body: some View {
        
        VStack{
            
            Spacer()
    
                Image("logo")
                    .resizable() // Allows the image to be resized
                    .scaledToFit() // Maintains the aspect ratio of the image
                // Specify the desired width and height
                    .frame(width: 200, height: 200)
     
            ZStack(alignment: .trailing) {
                TextField("Email", text: $searchText1)
                    .padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 50)) // Adjust left padding
                    .background(.white)
                    .foregroundColor(Color(hex: "0f2d53"))
                    .font(.body)
                    .bold()
                    .cornerRadius(37)
                    .frame(width: 300) // Set a specific width
                    .overlay(
                        RoundedRectangle(cornerRadius: 37)
                            .stroke(Color(hex: "0f2d53"), lineWidth: 2) // Customize border color and line width
                    )

                Image(systemName: "person.fill")
                    .resizable() // Make the image resizable
                    .aspectRatio(contentMode: .fit) // Keep the image aspect ratio
                    .frame(width: 24, height: 24)
                    .foregroundColor(Color(hex: "0f2d53")) // Adjust the color as needed
                    .padding(.trailing, 20) // Adjust the right padding to position the image
                
            }
            .padding(.top, 0)
            
            ZStack(alignment: .trailing) {
                TextField("Password", text: $searchText2)
                    .padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 50)) // Adjust left padding
                    .background(.white)
                    .foregroundColor(Color(hex: "0f2d53"))
                    .font(.body)
                    .bold()
                    .cornerRadius(37)
                    .frame(width: 300) // Set a specific width
                    .overlay(
                        RoundedRectangle(cornerRadius: 37)
                            .stroke(Color(hex: "0f2d53"), lineWidth: 2) // Customize border color and line width
                    )

                Image(systemName: "key.fill")
                    .resizable() // Make the image resizable
                    .aspectRatio(contentMode: .fit) // Keep the image aspect ratio
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color(hex: "0f2d53")) // Adjust the color as needed
                    .padding(.trailing, 20) // Adjust the right padding to position the image
                
            }
            .padding(.top, 15)
            
            Text("Forgot Password?")
                .padding(.top)
                .foregroundColor(Color(hex: "c7972b"))
            
            Spacer()
            
            HStack{
                
                NavigationLink(destination: SignUpView()){
                    Text("Sign Up")
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(Color(hex: "0f2d53"))
                }
            
                Spacer()
                
                Button(action: {
                    print("User Signed in")
                }){
                    Text("Log In")
                        .padding(EdgeInsets(top: 15, leading: 50, bottom: 15, trailing: 50))
                        .background(Color(red: 0.78, green: 0.592, blue: 0.169))
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                        .cornerRadius(37)
                        .padding()

                }
       
            }
        }
     
    }
}

#Preview {
    LoginView()
}
