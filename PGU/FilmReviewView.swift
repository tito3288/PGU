//
//  FilmReviewView.swift
//  PGU
//
//  Created by Bryan Arambula on 1/20/24.
//

import SwiftUI
import AVKit
import Combine

struct FilmReviewView: View {
    
    @State private var isMenuOpen: Bool = false
    @State private var selectedVideo: String? = nil // State for the selected video
    @State private var player: AVPlayer = AVPlayer() // Initialize an empty player
    @State private var isVideoPlaying: Bool = false // Track if the video is playing
    @Environment(\.scenePhase) private var scenePhase // Observe scenePhase
    private var scenePhaseCancellable: AnyCancellable? // Subscription
    

    
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
                    
                    NavigationLink(destination: CoachDrills()) {
                        Text("Coach Drills")
                            .padding(10)
                            .frame(minWidth: 0, maxWidth: .infinity) // Flexible frame
                            .background(Color(hex: "0f2d53"))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    
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
                    Image("coach-rob") // Placeholder
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
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
                // App is active, you might want to resume playing if that fits your use case
                break
            case .inactive, .background:
                // App is inactive or in the background, pause the video
                pauseVideo()
            @unknown default:
                break
            }
        }
        .onDisappear {
            // Ensure the video is paused when the view disappears
            pauseVideo()
        }
    }

    
    
    
    
    func togglePlayPause(for videoName: String) {
        // Check if a new video is selected or if it's the same as the current one.
        if selectedVideo != videoName || !isVideoPlaying {
            // A new video will start playing, or the same video will start playing from a paused state.
            // So, pause any podcast playback.
            NotificationCenter.default.post(name: .pausePodcastPlayback, object: nil)
        }
        
        if let currentVideo = selectedVideo, currentVideo == videoName {
            // If the clicked video is already selected, toggle play/pause.
            if isVideoPlaying {
                player.pause()
                // Since the video is paused, you might consider sending a resume notification here,
                // but only if it aligns with your app's logic (e.g., the podcast was playing before the video started).
                // NotificationCenter.default.post(name: .resumePodcastPlayback, object: nil)
            } else {
                player.play()
            }
            isVideoPlaying.toggle() // Toggle the play/pause state.
        } else {
            // If a different video is selected, play the new video.
            playVideo(named: videoName)
        }

        // If toggling resulted in pausing and there's a desire to automatically resume podcast playback,
        // consider carefully where to place the resume notification.
        // It might depend on additional state logic not shown here.
    }


    func playVideo(named videoName: String) {
        do {
            // Set the audio session category to playback
            try AVAudioSession.sharedInstance().setCategory(.playback)
            // Activate the audio session
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set audio session category or activate it: \(error)")
        }

        if let url = Bundle.main.url(forResource: videoName, withExtension: "mp4") {
            player.pause() // Ensure any currently playing video is paused
            let playerItem = AVPlayerItem(url: url)
            player.replaceCurrentItem(with: playerItem)
            player.play()
            
            selectedVideo = videoName
            isVideoPlaying = true // Mark the video as playing
        }
    }

    private func pauseVideo() {
        if isVideoPlaying {
            player.pause()
            isVideoPlaying = false

            do {
                // Deactivate the audio session
                try AVAudioSession.sharedInstance().setActive(false)
            } catch {
                print("Failed to deactivate audio session: \(error)")
            }
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
