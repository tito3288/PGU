//
//  ResourcesView.swift
//  PGU
//
//  Created by Bryan Arambula on 1/3/24.
//

import SwiftUI
import SWXMLHash // Import an XML parsing library
import AVFoundation
import UIKit
import MediaPlayer



struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

struct PodcastEpisode: Identifiable {
    let id: String
    let title: String
    var description: String
    let audioURL: URL // Add this for the audio file URL
    let imageURL: URL? // Add this to include an image URL
}


class AudioPlayerManager: ObservableObject {
    
    @Published var isPlaying = false
    @Published var currentPlayingURL: URL?
    
    var player: AVPlayer?
    
    @Published var playbackProgress: Double = 0
    private var timeObserverToken: Any?
    
    @Published var currentTime: TimeInterval = 0
    @Published var duration: TimeInterval = 0

    init() {
        setupProgressTracking()
        configureAudioSession()
        configureRemoteCommandCenter()
    }
    

    //MARK: THIS HELPS FOR AUDIO TO PLAY WHEN APP IS CLOSED OR LOCKED
    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set audio session category: \(error)")
        }
        
        
    }
    
    private func configureRemoteCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared()
        
        // Play command
        commandCenter.playCommand.isEnabled = true
        commandCenter.playCommand.addTarget { [weak self] event in
            // Check if the player is available and resume playback
            guard let self = self, let player = self.player else { return .commandFailed }
            if player.rate == 0 {
                player.play()
            }
            return .success
        }
        
        // Pause command
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget { [weak self] event in
            // Check if the player is available and pause playback
            guard let self = self, let player = self.player else { return .commandFailed }
            if player.rate != 0 {
                player.pause()
            }
            return .success
        }
        
    }
    
    
    
    func updateNowPlayingInfo() {
        guard let currentItem = player?.currentItem, let url = currentPlayingURL else { return }
        
        var nowPlayingInfo = [String: Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = "Episode Title" // Set dynamically if you have the info
        
        if let image = UIImage(named: "yourImageName") { // Replace with dynamic image loading if applicable
            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size) { _ in image }
        }
        
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = currentItem.currentTime().seconds
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = currentItem.asset.duration.seconds
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = isPlaying ? 1.0 : 0.0
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }

    
    func setupRemoteTransportControls() {
        let commandCenter = MPRemoteCommandCenter.shared()

        commandCenter.playCommand.addTarget { [unowned self] _ in
            self.play()
            return .success
        }

        commandCenter.pauseCommand.addTarget { [unowned self] _ in
            self.pause()
            return .success
        }
        
        // Add skip forward and backward commands as needed
    }

    func play() {
        player?.play()
        isPlaying = true
        updateNowPlayingInfo()
    }

    func pause() {
        player?.pause()
        isPlaying = false
        updateNowPlayingInfo()
    }

    
    func setupProgressTracking() {
        let interval = CMTime(seconds: 1, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserverToken = player?.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            DispatchQueue.main.async {
                self?.currentTime = time.seconds
                if let duration = self?.player?.currentItem?.duration.seconds, !duration.isNaN, duration.isFinite {
                    self?.duration = duration
                }
            }
        }
    }

    func seek(to progress: Double) {
        guard let duration = player?.currentItem?.duration else { return }
        let totalSeconds = CMTimeGetSeconds(duration)
        let value = totalSeconds * progress
        let seekTime = CMTime(value: Int64(value), timescale: 1)
        player?.seek(to: seekTime)
    }

    
    
    
    
    
    func playAudio(from url: URL) {
        // If there's an existing time observer, remove it
        if let timeObserverToken = timeObserverToken {
            player?.removeTimeObserver(timeObserverToken)
            self.timeObserverToken = nil
        }

        // Initialize the player with the new URL
        self.player = AVPlayer(url: url)
        self.player?.play()
        self.isPlaying = true
        self.currentPlayingURL = url

        // Now that player is not nil, set up the time observer
        setupProgressTracking()
    }
    
    func togglePlayPause(for url: URL) {
        // Check if we're trying to play the same episode
        if let currentPlayingURL = currentPlayingURL, currentPlayingURL == url {
            // Toggle play/pause
            isPlaying.toggle()
            if isPlaying {
                player?.play()
            } else {
                player?.pause()
            }
        } else {
            // New episode selected, play it
            self.currentPlayingURL = url
            isPlaying = true
            player = AVPlayer(url: url)
            player?.play()
        }
    }
    
    func skipBackward() {
        guard let player = player else { return }
        let currentTime = player.currentTime()
        let skipInterval = CMTime(seconds: -15, preferredTimescale: 1) // 15 seconds back
        let newTime = CMTimeAdd(currentTime, skipInterval)
        player.seek(to: newTime, toleranceBefore: .zero, toleranceAfter: .zero)
    }

    func skipForward() {
        guard let player = player else { return }
        let currentTime = player.currentTime()
        let skipInterval = CMTime(seconds: 30, preferredTimescale: 1) // 30 seconds forward
        let newTime = CMTimeAdd(currentTime, skipInterval)
        player.seek(to: newTime, toleranceBefore: .zero, toleranceAfter: .zero)
    }
    
    deinit {
        if let timeObserverToken = timeObserverToken {
            player?.removeTimeObserver(timeObserverToken)
            self.timeObserverToken = nil
        }
    }
    
    
}



//MARK: HANDLING RSS FROM PODBEAN
class PodcastService {
    func fetchEpisodes(completion: @escaping ([PodcastEpisode]) -> Void) {
        guard let url = URL(string: "https://feed.podbean.com/offthecourtpgu/feed.xml") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "Unknown error")
                return
            }
            
            let xml = XMLHash.parse(data)
            var episodes: [PodcastEpisode] = []
            
            for item in xml["rss"]["channel"]["item"].all {
                let id = item["guid"].element?.text ?? UUID().uuidString
                let title = item["title"].element?.text ?? "No Title"
                let description = item["description"].element?.text ?? "No Description"
                let audioURLString = item["enclosure"].element?.attribute(by: "url")?.text ?? ""
                let audioURL = URL(string: audioURLString)!
                let imageURLString = xml["rss"]["channel"]["image"]["url"].element?.text ?? ""
                let imageURL = URL(string: imageURLString)
                
                let episode = PodcastEpisode(id: id, title: title, description: description, audioURL: audioURL, imageURL: imageURL)
                episodes.append(episode)
            }
            
            DispatchQueue.main.async {
                completion(episodes)
            }
        }.resume()
    }
}




struct ResourcesView: View {
    
    @State private var isMenuOpen: Bool = false
    @StateObject private var audioPlayerManager = AudioPlayerManager()
    @State private var episodes: [PodcastEpisode] = []
    @State private var items: [String] = []
    
    @State private var selectedEpisode: PodcastEpisode?
    
    @State private var showPlaybackControls = false



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
                        Text("Rob's Clips")
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
                
                ZStack{
                    
                    List(episodes) { episode in
                        HStack{
                            
                            if let imageURL = episode.imageURL {
                                AsyncImage(url: imageURL) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                            
                            Text(episode.title)
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: "0f2d53"))// Style for regular text
                            
                            Spacer()
                            
                            Button(action: {
                                self.selectedEpisode = episode
                                audioPlayerManager.togglePlayPause(for: episode.audioURL)
                                withAnimation {
                                    showPlaybackControls = true
                                }
                            }) {
                                Image(systemName: audioPlayerManager.isPlaying && audioPlayerManager.currentPlayingURL == episode.audioURL ? "pause.fill" : "play.fill")
                                    .frame(alignment: .trailing)
                                    .padding(10)
                                    .background(Color(hex: "c7972b"))
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                
                            }
                            
                        }
                        
                    }
                    .listStyle(PlainListStyle())
                    .onAppear {
                        PodcastService().fetchEpisodes { fetchedEpisodes in
                            self.episodes = fetchedEpisodes
                        }
                    }
                    
                    

                    
                    PlaybackControlsView(audioPlayerManager: audioPlayerManager, selectedEpisode: selectedEpisode)
                        .offset(y: 80)
                        .padding(.horizontal)
                        .offset(y: showPlaybackControls ? 0 : UIScreen.main.bounds.height) // Start off-screen
                        .opacity(showPlaybackControls ? 1 : 0) // Fully visible when controls should be shown
                        .animation(.easeOut(duration: 0.5), value: showPlaybackControls) // Animate the appearance
                    
                    

                }

     
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
                    
                    
                    
                    Spacer()
                    
                    
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
        .navigationBarBackButtonHidden(true)
        
    }

}

struct PlaybackControlsView: View {
    @ObservedObject var audioPlayerManager: AudioPlayerManager
    var selectedEpisode: PodcastEpisode?
    @State private var showDetailSheet = false // State to control sheet presentation


    var body: some View {
        HStack {
            // Display episode image
            if let imageURL = selectedEpisode?.imageURL {
                AsyncImage(url: imageURL) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .onTapGesture {
                    self.showDetailSheet = true // Show sheet when image is tapped
                }
            }

            // Display episode title if available
            if let title = selectedEpisode?.title {
                Text(title)
                    .font(.headline)
                    .padding(.leading, 5)
                    .onTapGesture {
                        self.showDetailSheet = true // Show sheet when title is tapped
                    }
            }

            Spacer()

            // Play/Pause Button
            Button(action: {
                guard let episodeURL = selectedEpisode?.audioURL else { return }
                audioPlayerManager.togglePlayPause(for: episodeURL)
            }) {
                Image(systemName: audioPlayerManager.isPlaying && audioPlayerManager.currentPlayingURL == selectedEpisode?.audioURL ? "pause.fill" : "play.fill")
                    .foregroundColor(Color(hex: "c7972b"))
                    .padding()
                    .background(Circle().fill(Color.white))
            }
        }
        .padding()
        .background(BlurView(style: .systemUltraThinMaterial)) // Use BlurView here
        .cornerRadius(20)
        .frame(maxWidth: .infinity)
        .sheet(isPresented: $showDetailSheet) {
            // Provide the detailed view as the sheet's content
            if let episode = selectedEpisode {
                EpisodeDetailView(audioPlayerManager: audioPlayerManager, episode: episode)
            }
        }

    }
}




struct EpisodeDetailView: View {
    @ObservedObject var audioPlayerManager: AudioPlayerManager
    var episode: PodcastEpisode


    var body: some View {
        ZStack {
            // Background blur
            BlurView(style: .systemUltraThinMaterial)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 20) {
                
                if let imageURL = episode.imageURL {
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView() // Display a progress view while the image is loading
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 200, height: 200)
                                .clipShape(Circle()) // Makes the image circular
                                .shadow(radius: 10) // Optional: Adds a shadow for depth
                        case .failure:
                            Image(systemName: "photo") // An image to display in case of failure
                                .font(.largeTitle)
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
                
                // Episode title
                Text(episode.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Slider(value: $audioPlayerManager.playbackProgress, in: 0...1, onEditingChanged: { editing in
                    if !editing {
                        // Seek when the user stops dragging the slider
                        audioPlayerManager.seek(to: audioPlayerManager.playbackProgress)
                    }
                })
                .accentColor(.blue)
                
                
                
                HStack(spacing: 40) { // Adjust spacing as needed
                    // Skip backward 15 seconds
                    Button(action: {
                        audioPlayerManager.skipBackward()
                    }) {
                        Image(systemName: "gobackward.15")
                            .foregroundColor(Color.blue)
                            .padding()
                            .background(Circle().fill(Color.white))
                            .shadow(radius: 5)
                    }
                    
                    // Play/Pause Button
                    Button(action: {
                        audioPlayerManager.togglePlayPause(for: episode.audioURL) // Directly use episode.audioURL
                    }) {
                        Image(systemName: audioPlayerManager.isPlaying && audioPlayerManager.currentPlayingURL == episode.audioURL ? "pause.fill" : "play.fill")
                            .foregroundColor(Color.blue)
                            .padding()
                            .background(Circle().fill(Color.white))
                            .shadow(radius: 5)
                    }
                    
                    
                    // Skip forward 30 seconds
                    Button(action: {
                        audioPlayerManager.skipForward()
                    }) {
                        Image(systemName: "goforward.30")
                            .foregroundColor(Color.blue)
                            .padding()
                            .background(Circle().fill(Color.white))
                            .shadow(radius: 5)
                    }
                }
                
   
                
            }
            .padding()
        }
        
    }
    

}

extension TimeInterval {
    func asString(style: DateComponentsFormatter.UnitsStyle = .positional) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = [.pad]
        formatter.unitsStyle = style
        return formatter.string(from: self) ?? "0:00"
    }
}




#Preview {
    ResourcesView()
}
