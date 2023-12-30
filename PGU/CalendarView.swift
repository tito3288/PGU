//
//  CalendarView.swift
//  PGU
//
//  Created by Bryan Arambula on 12/4/23.
//

import SwiftUI

struct CalendarView: View {
    @State private var isMenuOpen: Bool = false
    @State private var selectedDates: Set<DateComponents> = Set()
    
    let eventDateRanges: [(start: Date, end: Date)] = [
        // Replace these with your actual event date ranges
        (start: Date(), end: Date().addingTimeInterval(86400 * 3)),
        (start: Date().addingTimeInterval(86400 * 7), end: Date().addingTimeInterval(86400 * 10)),
        // Add as many ranges as you have events
    ]
    
    
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
                    
                    NavigationLink(destination: CampsView()){
                        Text("Find a Camp")
                            .padding(10)
                            .background(Color(hex: "0f2d53"))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    
                    
                    Text("Calendar")
                        .padding(10)
                        .background(Color(hex: "c7972b"))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    NavigationLink(destination: CampInfoView()){
                        Text("Camp Info")
                            .padding(10)
                            .background(Color(hex: "0f2d53"))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    
                }
                .padding()
                
                
                MultiDatePicker("Calendar", selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Binding<Set<DateComponents>>@*/.constant([])/*@END_MENU_TOKEN@*/)
                
                
                List{
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Week 1")
                                .font(.title2) // Style for regular text
                            
                            Text("June 3 - June 6, 2024")
                                .font(.body) // Style for title text
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Your button action here
                            print("Button for Week  tapped")
                        }) {
                            Text("Sign Up") // Your button text
                                .frame(alignment: .trailing)
                                .padding(10)
                                .background(Color(hex: "c7972b"))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                    }
                    
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Week 2")
                                .font(.title2) // Style for regular text
                            
                            Text("June 16 - June 24, 2024")
                                .font(.body) // Style for title text
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Your button action here
                            print("Button for Week  tapped")
                        }) {
                            Text("Sign Up") // Your button text
                                .frame(alignment: .trailing)
                                .padding(10)
                                .background(Color(hex: "c7972b"))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                        
                    }
                    
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Week 3")
                                .font(.title2) // Style for regular text
                            
                            Text("June 3 - June 6, 2024")
                                .font(.body) // Style for title text
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Your button action here
                            print("Button for Week  tapped")
                        }) {
                            Text("Sign Up") // Your button text
                                .frame(alignment: .trailing)
                                .padding(10)
                                .background(Color(hex: "c7972b"))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                    }
                    
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Week 4")
                                .font(.title2) // Style for regular text
                            
                            Text("June 3 - June 6, 2024")
                                .font(.body) // Style for title text
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Your button action here
                            print("Button for Week  tapped")
                        }) {
                            Text("Sign Up") // Your button text
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
