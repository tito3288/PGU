//
//  ResourcesView.swift
//  PGU
//
//  Created by Bryan Arambula on 1/3/24.
//

import SwiftUI

struct PodcastEpisode: Identifiable, Codable {
    let id: String
    let title: String
    // Add other fields as necessary
}

class PodcastService {
    func fetchEpisodes(completion: @escaping ([PodcastEpisode]) -> Void) {
        let url = URL(string: "https://api.podbean.com/v1/episodes?access_token=YOUR_ACCESS_TOKEN")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "Unknown error")
                return
            }

            if let episodes = try? JSONDecoder().decode([PodcastEpisode].self, from: data) {
                DispatchQueue.main.async {
                    completion(episodes)
                }
            } else {
                print("Invalid response from server")
            }
        }.resume()
    }
}


struct ResourcesView: View {
    
    @State private var isMenuOpen: Bool = false
    @State private var episodes: [PodcastEpisode] = []

    
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
                    
                        Text("Podcast")
                            .padding(10)
                            .frame(minWidth: 0, maxWidth: .infinity) // Flexible frame
                            .background(Color(hex: "c7972b"))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))

                    Spacer() // Spacing between buttons

//                    NavigationLink(destination: CalendarView()) {
                        Text("Coach Drills")
                            .padding(10)
                            .frame(minWidth: 0, maxWidth: .infinity) // Flexible frame
                            .background(Color(hex: "0f2d53"))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
//                    }

                    Spacer() // Spacing between buttons
                    
                    NavigationLink(destination: FilmReviewView()) {
                        Text("Rob's Videos")
                            .padding(10)
                            .frame(minWidth: 0, maxWidth: .infinity) // Flexible frame
                            .background(Color(hex: "0f2d53"))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
                .padding()
                
                
                Image("podcast-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                
                List(episodes) { episode in

                    HStack{
                        VStack(alignment: .leading, spacing: 0) {
                            Text(episode.title)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: "0f2d53"))
                        }
                        .onAppear {
                            PodcastService().fetchEpisodes { fetchedEpisodes in
                                self.episodes = fetchedEpisodes
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Your button action here
                            print("Sign Up pressed")
                        }) {
                            Image(systemName: "play.fill") // Your button text
                                .frame(alignment: .trailing)
                                .padding(10)
                                .background(Color(hex: "c7972b"))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                    }
                    
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Episode 3: Podcast Name")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: "0f2d53"))// Style for regular text
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Your button action here
                            print("Sign Up pressed")
                        }) {
                            Image(systemName: "play.fill") // Your button text
                                .frame(alignment: .trailing)
                                .padding(10)
                                .background(Color(hex: "c7972b"))
                                .foregroundColor(.white)
                                .cornerRadius(20)

                        }
                        
                    }
                    
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Episode 2: Podcast Name")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: "0f2d53"))// Style for regular text
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Your button action here
                            print("Sign Up pressed")
                        }) {
                            Image(systemName: "play.fill") // Your button text
                                .frame(alignment: .trailing)
                                .padding(10)
                                .background(Color(hex: "c7972b"))
                                .foregroundColor(.white)
                                .cornerRadius(20)

                        }
                    }
                    
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Epospde 1: Podcast Name")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: "0f2d53"))// Style for regular text
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Your button action here
                            print("Sign Up pressed")
                        }) {
                            Image(systemName: "play.fill") // Your button text
                                .frame(alignment: .trailing)
                                .padding(10)
                                .background(Color(hex: "c7972b"))
                                .foregroundColor(.white)
                                .cornerRadius(20)

                        }
                        
                    }
                    
                }
                .listStyle(PlainListStyle()) // Removes extra padding and separators in iOS 14+
                
//                FooterMenu()
                
                Divider()
                
                HStack {
                    
                    Spacer()

                    NavigationLink(destination: ProfileView()) {
                        VStack{
                            Image(systemName: "person")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.gray)
                                .frame(width: 25, height: 25)// Example icon
                            Text("Profile")
                                .foregroundColor(.gray)
                                .fontWeight(.bold)

                        }
                    }

                        
                    
                    Spacer()
                    
                    NavigationLink(destination: InboxView()) {
                        VStack{
                            Image(systemName: "tray.full")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.gray)
                                .frame(width: 25, height: 25)// Example icon
                            Text("Inbox")
                                .foregroundColor(.gray)
                                .fontWeight(.bold)

                        }
                    }

                        
                    
                    Spacer()
                    
        //            Button(action: {
        //                // Action for the third icon
        //            }) {
                    NavigationLink(destination: CampsView()) {
                        VStack{
                            Image(systemName: "mappin.and.ellipse")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.gray)
                                .frame(width: 25, height: 25)// Example icon
                            Text("Camps")
                                .foregroundColor(.gray)
                                .fontWeight(.bold)

                        }
                    }

                        
        //            }
                    
                    Spacer()
                    
//                    NavigationLink(destination: ResourcesView()) {

                        VStack{
                            Image(systemName: "basketball")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.gray)
                                .frame(width: 25, height: 25)// Example icon
                            Text("Resources")
                                .foregroundColor(.gray)
                                .fontWeight(.bold)
                        }
                        
//                    }

                    Spacer()

                }
                .padding(.top)
                .background(Color.white)
                
                

            }
            if isMenuOpen {
                MenuView(isMenuOpen: $isMenuOpen)
                    .frame(width: UIScreen.main.bounds.width)
                    .transition(.move(edge: .leading))
            }
        }
        .navigationBarBackButtonHidden(true)    }
    
    
}




#Preview {
    ResourcesView()
}
