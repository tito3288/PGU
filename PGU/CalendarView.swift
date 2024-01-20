//
//  CalendarView.swift
//  PGU
//
//  Created by Bryan Arambula on 12/4/23.
//

import SwiftUI


struct CalendarView: View {
    
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
                
                
                HStack {
                    NavigationLink(destination: CampsView()) {
                        Text("Find Camp")
                            .padding(10)
                            .frame(minWidth: 0, maxWidth: .infinity) // Flexible frame
                            .background(Color(hex: "0f2d53"))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }

                    Spacer() // Spacing between buttons

                    NavigationLink(destination: CalendarView()) {
                        Text("Calendar")
                            .padding(10)
                            .frame(minWidth: 0, maxWidth: .infinity) // Flexible frame
                            .background(Color(hex: "c7972b"))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }

                    Spacer() // Spacing between buttons

                    Text("Camp Info")
                        .padding(10)
                        .frame(minWidth: 0, maxWidth: .infinity) // Flexible frame
                        .background(Color(hex: "0f2d53"))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .padding()
                
                
                MultiDatePicker("Calendar", selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Binding<Set<DateComponents>>@*/.constant([])/*@END_MENU_TOKEN@*/)
                    .accentColor(.red)
                
                
                List{
                    HStack{
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Dodge City, KS")
                                .font(.title2) // Style for regular text

                            Text("May 28th- May 31st, 2024")
                                .font(.body) // Style for title text
                        }
                        
                        Spacer()
                        
                        Button(action: {
                           print("Sign Up")
                        }){
                            Text("Sign Up")
                                .frame(alignment: .trailing)
                                .padding(10)
                                .background(Color(hex: "c7972b"))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                        
                    }
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Limon, CO")
                                .font(.title2) // Style for regular text

                            Text("June 3rd- June 6th, 2024")
                                .font(.body) // Style for title text
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            print("Sign Up")
                        }){
                            Text("Sign Up")
                                .frame(alignment: .trailing)
                                .padding(10)
                                .background(Color(hex: "c7972b"))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                        
                    }
                    
                    
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Goodland, KS")
                                .font(.title2) // Style for regular text

                            Text("June 10th- June 13th, 2024")
                                .font(.body) // Style for title text
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            print("Sign Up")
                        }){
                            Text("Sign Up")
                                .frame(alignment: .trailing)
                                .padding(10)
                                .background(Color(hex: "c7972b"))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                        
                    }
                    
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Canton, KS")
                                .font(.title2) // Style for regular text

                            Text("June 17th- June 20th, 2024")
                                .font(.body) // Style for title text
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            print("Sign Up")
                        }){
                            Text("Sign Up")
                                .frame(alignment: .trailing)
                                .padding(10)
                                .background(Color(hex: "c7972b"))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                    }
                    
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Grand Rapids, MI")
                                .font(.title2) // Style for regular text

                            Text("June 17th- June 20th, 2024")
                                .font(.body) // Style for title text
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            print("Sign Up")
                        }){
                            Text("Sign Up")
                                .frame(alignment: .trailing)
                                .padding(10)
                                .background(Color(hex: "c7972b"))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                    }
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Lafayette, IN")
                                .font(.title2) // Style for regular text

                            Text("June 24th- June 27th, 2024")
                                .font(.body) // Style for title text
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            print("Sign Up")
                        }){
                            Text("Sign Up")
                                .frame(alignment: .trailing)
                                .padding(10)
                                .background(Color(hex: "c7972b"))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                    }
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 0) {
                            Text("South Bend, IN")
                                .font(.title2) // Style for regular text

                            Text("July 8th- July 11th, 2024")
                                .font(.body) // Style for title text
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            print("Sign Up")
                        }){
                            Text("Sign Up")
                                .frame(alignment: .trailing)
                                .padding(10)
                                .background(Color(hex: "c7972b"))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                    }
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Hornell, NY")
                                .font(.title2) // Style for regular text

                            Text("July 22nd- July 25th, 2024")
                                .font(.body) // Style for title text
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            print("Sign Up")
                        }){
                            Text("Sign Up")
                                .frame(alignment: .trailing)
                                .padding(10)
                                .background(Color(hex: "c7972b"))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                    }
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Rochester, NY")
                                .font(.title2) // Style for regular text

                            Text("July 29- August 1st, 2024")
                                .font(.body) // Style for title text
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            print("Sign Up")
                        }){
                            Text("Sign Up")
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
        .navigationBarBackButtonHidden(true)
    }
    
    
}

#Preview {
    CalendarView()
}
