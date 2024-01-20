//
//  FilmReviewView.swift
//  PGU
//
//  Created by Bryan Arambula on 1/20/24.
//

import SwiftUI
import AVKit


struct FilmReviewView: View {
    
    @State private var isMenuOpen: Bool = false
    @State private var selectedVideo: String? = nil // State for the selected video
    
    
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
                        Text("Podcast")
                            .padding(10)
                            .frame(minWidth: 0, maxWidth: .infinity) // Flexible frame
                            .background(Color(hex: "0f2d53"))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    
                    Spacer() // Spacing between buttons
                    
                    NavigationLink(destination: CalendarView()) {
                        Text("Coach Drills")
                            .padding(10)
                            .frame(minWidth: 0, maxWidth: .infinity) // Flexible frame
                            .background(Color(hex: "0f2d53"))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    
                    Spacer() // Spacing between buttons
                    
                    Text("Film Review")
                        .padding(10)
                        .frame(minWidth: 0, maxWidth: .infinity) // Flexible frame
                        .background(Color(hex: "c7972b"))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .padding()
                
                
                if let videoName = selectedVideo {
                    VideoPlayerView(videoName: videoName)
                        .aspectRatio(contentMode: .fit)
                        .padding()
                } else {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                }
                
                
                List{
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Episode 4: Video Name")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: "0f2d53"))// Style for regular text
                                .onTapGesture {
                                    self.selectedVideo = "pgu-video" // Set the video to play
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
                            Text("Episode 3: Video Name")
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
                            Text("Episode 2: Video Name")
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
                            Text("Epospde 1: Video Name")
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

struct VideoPlayerView: View {
    var videoName: String
    
    var body: some View {
        let player = AVPlayer(url: Bundle.main.url(forResource: videoName, withExtension: "mp4")!)
        VideoPlayer(player: player)
            .onAppear {
                player.play()
            }
    }
}

#Preview {
    FilmReviewView()
}
