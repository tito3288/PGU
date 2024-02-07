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
    @State private var player: AVPlayer = AVPlayer() // Initialize an empty player
    @State private var isVideoPlaying: Bool = false // Track if the video is playing

    
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
                    NavigationLink(destination: ResourcesView()) {
                        Text("Podcast")
                            .padding(10)
                            .frame(minWidth: 0, maxWidth: .infinity) // Flexible frame
                            .background(Color(hex: "0f2d53"))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    
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
                    
                    Text("Rob's Clips")
                        .padding(10)
                        .frame(minWidth: 0, maxWidth: .infinity) // Flexible frame
                        .background(Color(hex: "c7972b"))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .padding()
                
                
                if let videoName = selectedVideo, Bundle.main.url(forResource: videoName, withExtension: "mp4") != nil {
                    VideoPlayer(player: player)
                        // Additional logic to control play/pause based on `isVideoPlaying`
                } else {
                    Image("logo") // Placeholder
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                }
                
                
                List{
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Coach Rob Shows You Ball-Handling Drills Without Dribbling")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: "0f2d53"))// Style for 
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            let videoName = "pgu-video2" // Example video name
                            togglePlayPause(for: videoName)
                        }) {
                            Image(systemName: selectedVideo == "pgu-video2" && isVideoPlaying ? "pause.fill" : "play.fill")
                                .frame(alignment: .trailing)
                                .padding(10)
                                .background(Color(hex: "c7972b"))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                    }
                    
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Coach Rob Teaches Shooting Mechanics")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: "0f2d53"))// Style for regular text
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            let videoName = "pgu-video3" // Example video name
                            togglePlayPause(for: videoName)                        }) {
                                Image(systemName: selectedVideo == "pgu-video3" && isVideoPlaying ? "pause.fill" : "play.fill")
                                    .frame(alignment: .trailing)
                                    .padding(10)
                                    .background(Color(hex: "c7972b"))
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                        }
                        
                    }
                    
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Coach Rob Teaches The Between-The-Legs Into Shot Move")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: "0f2d53"))// Style for regular text
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            let videoName = "pgu-video4" // Example video name
                            togglePlayPause(for: videoName)                        }) {
                                Image(systemName: selectedVideo == "pgu-video4" && isVideoPlaying ? "pause.fill" : "play.fill")
                                    .frame(alignment: .trailing)
                                    .padding(10)
                                    .background(Color(hex: "c7972b"))
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                            
                        }
                    }
                    
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Coach Rob Teaches The Spin Move")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: "0f2d53"))// Style for regular text
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            let videoName = "pgu-video5" // Example video name
                            togglePlayPause(for: videoName)                        }) {
                                Image(systemName: selectedVideo == "pgu-video5" && isVideoPlaying ? "pause.fill" : "play.fill")
                                    .frame(alignment: .trailing)
                                    .padding(10)
                                    .background(Color(hex: "c7972b"))
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                        }
                        
                    }
                    
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Coach Rob Teaches You The Art Of The Floater")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: "0f2d53"))// Style for regular text
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            let videoName = "pgu-video6" // Example video name
                            togglePlayPause(for: videoName)                        }) {
                                Image(systemName: selectedVideo == "pgu-video6" && isVideoPlaying ? "pause.fill" : "play.fill")
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
    
    func togglePlayPause(for videoName: String) {
        if let currentVideo = selectedVideo, currentVideo == videoName {
            // If the clicked video is already selected, toggle play/pause
            if isVideoPlaying {
                player.pause()
            } else {
                player.play()
            }
            isVideoPlaying.toggle() // Toggle the play/pause state
        } else {
            // If a different video is selected, play the new video
            playVideo(named: videoName)
        }
    }

    func playVideo(named videoName: String) {
        if let url = Bundle.main.url(forResource: videoName, withExtension: "mp4") {
            player.pause() // Ensure any currently playing video is paused
            let playerItem = AVPlayerItem(url: url)
            player.replaceCurrentItem(with: playerItem)
            player.play()
            
            selectedVideo = videoName
            isVideoPlaying = true // Mark the video as playing
        }
    }

    
}



struct VideoPlayerView: View {
    var videoName: String
    private var player: AVPlayer

    init(videoName: String) {
        self.videoName = videoName
        if let url = Bundle.main.url(forResource: videoName, withExtension: "mp4") {
            self.player = AVPlayer(url: url)
        } else {
            // Handle the error of missing file appropriately
            self.player = AVPlayer() // Placeholder to avoid optional AVPlayer
        }
    }

    var body: some View {
        VideoPlayer(player: player)
            .onAppear {
                player.play()
            }
            .onDisappear {
                player.pause()
            }
    }
}


#Preview {
    FilmReviewView()
}