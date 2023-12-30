//
//  MenuView.swift
//  PGU
//
//  Created by Bryan Arambula on 12/4/23.
//

import SwiftUI

struct MenuView: View {
    
    @Binding var isMenuOpen: Bool
    
    var body: some View {
        
        
        ZStack {
            Color(hex: "0f2d53").edgesIgnoringSafeArea(.all)
            
            //Figure out how the text stays in the middle of the screen. ⬇️
            
            List {
                Group {
                    NavigationLink(destination: HomeView()) {
                        HStack{
                            Spacer()
                            Text("Home").font(.title2).padding()
                            Spacer()
                        }
                    }
                    .listRowBackground(Color(hex: "0f2d53"))
                    .listRowInsets(EdgeInsets())
                    
                    NavigationLink(destination: CampInfoView()){
                        HStack{
                            Spacer()
                            Text("Camp Info").font(.title2).padding()
                            Spacer()
                        }
                    }
                    .listRowBackground(Color(hex: "0f2d53"))
                    .listRowInsets(EdgeInsets())
                    NavigationLink(destination: CalendarView()){
                        HStack{
                            Spacer()
                            Text("Camp Calendar").font(.title2).padding()
                            Spacer()
                        }
                    }
                    .listRowBackground(Color(hex: "0f2d53"))
                    .listRowInsets(EdgeInsets())
                    NavigationLink(destination: CampsView()){
                        HStack{
                            Spacer()
                            Text("Camp Locations").font(.title2).padding()
                            Spacer()
                        }
                    }
                    .listRowBackground(Color(hex: "0f2d53"))
                    .listRowInsets(EdgeInsets())
                    Text("Clinic Schedule").font(.title2)
                        .padding().listRowBackground(Color(hex: "0f2d53"))
                        .listRowInsets(EdgeInsets())
                    Text("Contact Us").font(.title2)
                        .padding().listRowBackground(Color(hex: "0f2d53"))
                        .listRowInsets(EdgeInsets())
                }
                .frame(maxWidth: .infinity, alignment: .center) // Center text in each row
                .background(Color.white)
                .cornerRadius(25)
                .listRowInsets(EdgeInsets())
                .padding(.horizontal)
                .padding(.bottom)
                .listRowBackground(Color.clear)
                
                
                
                Text("Log Out")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.title2)
                    .padding()
                    .background(Color(hex: "c7972b"))
                    .cornerRadius(25)// Clear background for the Log Out row
                    .listRowInsets(EdgeInsets()) // Removes default padding
                    .padding(.horizontal)
                    .listRowBackground(Color(hex: "0f2d53"))
                
                
                Text("FOLLOW US")
                    .listRowBackground(Color(hex: "0f2d53"))
                    .foregroundColor(Color.white)
                    .font(.title3)
                    .padding()
            }
            .listStyle(PlainListStyle())
            .padding(.top, 150)
            .background(Color(hex: "0f2d53"))
            .edgesIgnoringSafeArea(.all) // Ignore safe areas to extend to the top and bottom of the screen
        }
        
    }
    
    
}




#Preview {
    MenuView(isMenuOpen: .constant(true))
}
