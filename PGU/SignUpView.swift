//
//  SignUpView.swift
//  PGU
//
//  Created by Bryan Arambula on 12/31/23.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var searchText1 = "" // State variable to hold search text
    @State private var searchText2 = "" // State variable to hold search text
    
    @State private var isLocationVisible: Bool = false

    
    var body: some View {
        VStack{
            
            Spacer()
            
            Image("logo")
                .resizable() // Allows the image to be resized
                .scaledToFit() // Maintains the aspect ratio of the image
            // Specify the desired width and height
                .frame(width: 200, height: 200)
            
            TextField("Name", text: $searchText1)
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
            
            
            TextField("Email", text: $searchText2)
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
                .padding(.top, 15)
            
            TextField("Phone Number", text: $searchText2)
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
                .padding(.top, 15)
            
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
                .padding(.top, 15)
            
            
            //FIRST DROPDOWN OPTION
            VStack {
                //                Spacer()
                // ... other elements ...
                
                if isLocationVisible {
                    ScrollView {
                        VStack {
                            HStack{
                                
                                Button(action:{
                                    print("Location clicked")
                                }){
                                    Text("Upstate New York")
                                    
                                }
                                
                            }
                            .padding(EdgeInsets(top: 15, leading: 50, bottom: 15, trailing: 50))
                            .background(Color(red: 0.78, green: 0.592, blue: 0.169))
                            .foregroundColor(.white)
                            .font(.title3)
                            .bold()
                            .cornerRadius(37)
                            .padding(.top)
                            
                            HStack{
                                
                                Button(action:{
                                    print("Location clicked")
                                }){
                                    Text("Northern Indiana")
                                    
                                }
                                
                            }
                            .padding(EdgeInsets(top: 15, leading: 50, bottom: 15, trailing: 50))
                            .background(Color(red: 0.78, green: 0.592, blue: 0.169))
                            .foregroundColor(.white)
                            .font(.title3)
                            .bold()
                            .cornerRadius(37)
//                            .padding(.top)
                            
                            HStack{
                                
                                Button(action:{
                                    print("Location clicked")
                                }){
                                    Text("Central Indiana")
                                    
                                }
                                
                            }
                            .padding(EdgeInsets(top: 15, leading: 50, bottom: 15, trailing: 50))
                            .background(Color(red: 0.78, green: 0.592, blue: 0.169))
                            .foregroundColor(.white)
                            .font(.title3)
                            .bold()
                            .cornerRadius(37)
//                            .padding(.top)
                            
                            HStack{
                                
                                Button(action:{
                                    print("Location clicked")
                                }){
                                    Text("Eastern Kansas")
                                    
                                }
                                
                            }
                            .padding(EdgeInsets(top: 15, leading: 50, bottom: 15, trailing: 50))
                            .background(Color(red: 0.78, green: 0.592, blue: 0.169))
                            .foregroundColor(.white)
                            .font(.title3)
                            .bold()
                            .cornerRadius(37)
//                            .padding(.top)
                            
                            HStack{
                                
                                Button(action:{
                                    print("Location clicked")
                                }){
                                    Text("Central Kansas")
                                    
                                }
                                
                            }
                            .padding(EdgeInsets(top: 15, leading: 50, bottom: 15, trailing: 50))
                            .background(Color(red: 0.78, green: 0.592, blue: 0.169))
                            .foregroundColor(.white)
                            .font(.title3)
                            .bold()
                            .cornerRadius(37)
//                            .padding(.top)
                            
                            HStack{
                                
                                Button(action:{
                                    print("Location clicked")
                                }){
                                    Text("Western Kansas")
                                    
                                }
                                
                            }
                            .padding(EdgeInsets(top: 15, leading: 50, bottom: 15, trailing: 50))
                            .background(Color(red: 0.78, green: 0.592, blue: 0.169))
                            .foregroundColor(.white)
                            .font(.title3)
                            .bold()
                            .cornerRadius(37)
//                            .padding(.top)
                            
                            HStack{
                                
                                Button(action:{
                                    print("Location clicked")
                                }){
                                    Text("Eastern Kansas")
                                    
                                }
                                
                            }
                            .padding(EdgeInsets(top: 15, leading: 50, bottom: 15, trailing: 50))
                            .background(Color(red: 0.78, green: 0.592, blue: 0.169))
                            .foregroundColor(.white)
                            .font(.title3)
                            .bold()
                            .cornerRadius(37)
//                            .padding(.top)
                            
                            HStack{
                                
                                Button(action:{
                                    print("Location clicked")
                                }){
                                    Text("Nebraska")
                                    
                                }
                                
                            }
                            .padding(EdgeInsets(top: 15, leading: 50, bottom: 15, trailing: 50))
                            .background(Color(red: 0.78, green: 0.592, blue: 0.169))
                            .foregroundColor(.white)
                            .font(.title3)
                            .bold()
                            .cornerRadius(37)
//                            .padding(.top)
                            
                        }
                    }
                    .frame(height: 200)
                }
                // The 'Location' HStack (the button to toggle visibility)
                // (This is outside the ScrollView and shown when isLocationVisible is false)
                HStack {
                    Text("Location")
                    Spacer()
                    Button(action: {
                        withAnimation(.easeInOut) {
                            self.isLocationVisible.toggle()
                        }
                    }) {
                        Image(systemName: "chevron.down")
                            .frame(alignment: .trailing)
                            .padding(9)
                            .background(Color(hex: "c7972b"))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 15))
                .background(.white)
                .foregroundColor(Color(hex: "0f2d53"))
                .font(.body)
                .bold()
                .cornerRadius(37)
                .frame(width: 300)
                .overlay(
                    RoundedRectangle(cornerRadius: 37)
                        .stroke(Color(hex: "0f2d53"), lineWidth: 2)
                )
                .padding(.top, 15)
       
            }
            .animation(.easeInOut, value: isLocationVisible) // Apply animation here

            //********
 
            //SECOND DROPDOWN OPTION
//            HStack {
//                Text("Location")
//                Spacer()
//
//                Menu {
//                    Button("Upstate New York", action: { /* Handle Option 1 */ })
//                    Button("Northern Indiana", action: { /* Handle Option 2 */ })
//                    Button("Central Indiana", action: { /* Handle Option 1 */ })
//                    Button("Eastern Kansas", action: { /* Handle Option 2 */ })
//                    Button("Central Kansas", action: { /* Handle Option 1 */ })
//                    Button("Western Kansas", action: { /* Handle Option 2 */ })
//                    Button("Eastern Colorado", action: { /* Handle Option 1 */ })
//                    Button("Nebraska", action: { /* Handle Option 2 */ })
//                } label: {
//                    Image(systemName: "chevron.down") // Your button text
//                        .frame(alignment: .trailing)
//                        .padding(9)
//                        .background(Color(hex: "c7972b"))
//                        .foregroundColor(.white)
//                        .cornerRadius(20)
//                }
//            }
//            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 15)) // Adjust left padding
//            .background(.white)
//            .foregroundColor(Color(hex: "0f2d53"))
//            .font(.body)
//            .bold()
//            .cornerRadius(37)
//            .frame(width: 300) // Set a specific width
//            .overlay(
//                RoundedRectangle(cornerRadius: 37)
//                    .stroke(Color(hex: "0f2d53"), lineWidth: 2) // Customize border color and line width
//            )
//            .padding(.top, 15)

          
            
            Spacer()

            Button(action: {
                print("Created an account")
            }){
                Text("Create Account")
                
            }
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

#Preview {
    SignUpView()
}
