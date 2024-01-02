//
//  CampInfoView.swift
//  PGU
//
//  Created by Bryan Arambula on 12/4/23.
//

import SwiftUI

struct CampInfoView: View {
    
    
    @State private var isMenuOpen: Bool = false
    
    
    var body: some View {
     
        ZStack{
            VStack{
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
                    
                    NavigationLink(destination: CalendarView()){
                        Text("Calendar")
                            .padding(10)
                            .background(Color(hex: "0f2d53"))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                   
                    Text("Camp Info")
                        .padding(10)
                        .background(Color(hex: "c7972b"))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                
                Image("logo3")
                    .resizable()
                    .frame(width: 312, height: 212)
                    .padding()
                
                
                ScrollView{
                    
                    Text("HOW WE'RE DIFFERENT")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom)
                    
                    
                    Text("We don't throw the ball up and scrimmage.")
                        .padding(.bottom)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    
                    Text("We create relationships. We make sure your athlete leaves with drills and a plan to become a better player. We make sure your athlete stays involved, has fun and create lifelong memories.")
                        .padding(.bottom)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    
                    Text("We cap the number of athletes that can attend each camp for a reason. We make sure everyone gets individual attention and instruction.")
                        .padding(.bottom)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    
                    Text("We take this seriously. Just like a real game, we have a gameplan every week, every day and every hour. We don't leave anything to chance, there is intention behind each decision.")
                        .padding(.bottom)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    
                    Text("OUR IMPACT")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    
                    Text("We have welcomed over 5,000 campers since 2017.")
                        .padding(.bottom)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    
                    Text("With the help of our sponsors this year, we will welcome over 200 athletes to camps and clinics that otherwise would not have been able to afford it.")
                        .padding(.bottom)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    
                    Text("This year, we will hold free clinics in every state we attend on our tour.")
                        .padding(.bottom)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    
                    Text("This year, we will give back thousands of dollars to local communities, local athletic departments and local athletic clubs.")
                        .padding(.bottom)
                        .frame(maxWidth: .infinity, alignment: .leading)

               
                }
                .padding(.trailing)
                .padding(.leading)
    
                FooterMenu()
            }
            
            if isMenuOpen {
                MenuView(isMenuOpen: $isMenuOpen)
                    .frame(width: UIScreen.main.bounds.width)
                    .transition(.move(edge: .leading))
            }
        }
        

    }
    
    
}

#Preview {
    CampInfoView()
}
