//
//  MenuView.swift
//  PGU
//
//  Created by Bryan Arambula on 12/4/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct MenuView: View {
 
    
    @Binding var isMenuOpen: Bool
    @State private var showingLogoutAlert = false
    @State private var navigateToLogin = false
    
    @State private var userName = "@Username"  // State variable for user's name

    
    var body: some View {
        
        
        ZStack {
            Color(hex: "0f2d53").edgesIgnoringSafeArea(.all)
            
            //Figure out how the text stays in the middle of the screen. ⬇️

            List {
                (Text("Hello ")
                    .foregroundColor(Color.white) +
                Text(userName)
                    .foregroundColor(Color(hex: "c7972b")))
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.bottom)
                    .listRowBackground(Color(hex: "0f2d53"))


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
                    
                    NavigationLink(destination: ResourcesView()){
                        HStack{
                            Spacer()
                            Text("Resources").font(.title2).padding()
                            Spacer()
                        }                    }
                    .listRowBackground(Color(hex: "0f2d53"))
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

                
                
                Text("FOLLOW US")
                    .listRowBackground(Color(hex: "0f2d53"))
                    .foregroundColor(Color.white)
                    .font(.title3)
                    .padding(.top)
                    .fontWeight(.bold)
                
                HStack {
                    Link(destination: URL(string: "https://www.facebook.com/handlethegame")!) {
                        Image("facebook-icon")
                    }
                    
                    Link(destination: URL(string: "https://www.instagram.com/handlethegame/")!) {
                        Image("instagram-icon")
                    }
                    
                    Link(destination: URL(string: "https://www.tiktok.com/@pointguardu")!) {
                        Image("tik-tok-icon")
                    }
                }
                .listRowBackground(Color(hex: "0f2d53"))
                .foregroundColor(Color.white)
                .font(.title3)
            
                
            }
            .onAppear(perform: loadUserData)
            .listStyle(PlainListStyle())
            .padding(.top, 110)//THIS CREATES PADDING FOR THE TOP OF THE ENTIRE VSTACK
            .background(Color(hex: "0f2d53"))
            .edgesIgnoringSafeArea(.all) // Ignore safe areas to extend to the top and bottom of the screen
        }
        .alert(isPresented: $showingLogoutAlert) {
            Alert(
                title: Text("Are you sure you want to log out?"),
                primaryButton: .destructive(Text("Yes")) {
                    // Perform logout operation
                    do {
                        try Auth.auth().signOut()
                        self.navigateToLogin = true
                    } catch let signOutError {
                        print("Error signing out: \(signOutError)")
                    }
                },
                secondaryButton: .cancel()
            )
        }
        
        NavigationLink(destination: LoginView(), isActive: $navigateToLogin) {
            EmptyView()
        }
        
        

        
    }
    
    
    //MARK: LOGIC TO RETREIVE NAME FROM FIRESTORE
    private func loadUserData() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        db.collection("users").document(userID).getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data()
                self.userName = data?["name"] as? String ?? "User"
            } else {
                print("Document does not exist")
            }
        }
    }
    
//    func handleTap(with urlString: String) {
//        print("URL Tapped: \(urlString)") // Add this for debugging
//
//        if let url = URL(string: urlString) {
//            openURL(url)
//        } else {
//            print("Invalid URL")
//        }
//    }
 
}


//MARK: LOGIC FOR OPENING AN EXTERIOR LINK LIKE FACEBOOK AND TIKTOK
//func openURL(_ url: URL) {
//    UIApplication.shared.open(url, options: [:], completionHandler: nil)
//}




#Preview {
    MenuView(isMenuOpen: .constant(true))
}
