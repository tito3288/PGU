//
//  MenuView.swift
//  PGU
//
//  Created by Bryan Arambula on 12/4/23.
//

import SwiftUI

struct MenuView: View {
    
    @Binding var isMenuOpen: Bool
    @State private var showingLogoutAlert = false
    @State private var navigateToLogin = false
    
    var body: some View {
        
        
        ZStack {
            Color(hex: "0f2d53").edgesIgnoringSafeArea(.all)
            
            //Figure out how the text stays in the middle of the screen. ⬇️

            List {
                Text("Hello @Username")
                    .listRowBackground(Color(hex: "0f2d53"))
                    .foregroundColor(Color.white)
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.bottom)

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
                
                
                
                Button(action: {
                    self.showingLogoutAlert = true
                    print("hello world")
                }) {
                    Text("Log Out")
                        
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.title2)
                .padding()
                .background(Color(hex: "c7972b"))
                .cornerRadius(25)// Clear background for the Log Out row
                .listRowInsets(EdgeInsets()) // Removes default padding
                .padding(.horizontal)
                .listRowBackground(Color(hex: "0f2d53"))

                
//                Text("Log Out")
//                    .frame(maxWidth: .infinity, alignment: .center)
//                    .font(.title2)
//                    .padding()
//                    .background(Color(hex: "c7972b"))
//                    .cornerRadius(25)
//                    .listRowInsets(EdgeInsets())
//                    .padding(.horizontal)
//                    .listRowBackground(Color(hex: "0f2d53"))
                
                
                Text("FOLLOW US")
                    .listRowBackground(Color(hex: "0f2d53"))
                    .foregroundColor(Color.white)
                    .font(.title3)
                    .padding(.top)
                
                HStack{
                    
                    Button(action: {
                        openURL(URL(string:"https://www.facebook.com/alphadogagency")!)

                    }){
                        Image("facebook-icon")
                        
                    }
                    
                    
                    Button(action: {
                        openURL(URL(string:"https://www.instagram.com/alphadogagency/")!)
                    }){
                        Image("instagram-icon")
                        
                    }
                    
                }
                .listRowBackground(Color(hex: "0f2d53"))
                .foregroundColor(Color.white)
                .font(.title3)
                
            }
            .listStyle(PlainListStyle())
            .padding(.top, 110)//THIS CREATES PADDING FOR THE TOP OF THE ENTIRE VSTACK
            .background(Color(hex: "0f2d53"))
            .edgesIgnoringSafeArea(.all) // Ignore safe areas to extend to the top and bottom of the screen
        }
        .alert(isPresented: $showingLogoutAlert) {
            Alert(
                title: Text("Are you sure you want to log out?"),
                primaryButton: .destructive(Text("Yes")) {
                    self.navigateToLogin = true
                },
                secondaryButton: .cancel()
            )
        }
        
        NavigationLink(destination: LoginView(), isActive: $navigateToLogin) {
            EmptyView()
        }

        
    }
    
    
}

func openURL(_ url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }


#Preview {
    MenuView(isMenuOpen: .constant(true))
}
