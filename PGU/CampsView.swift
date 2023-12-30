//
//  CampsView.swift
//  PGU
//
//  Created by Bryan Arambula on 12/4/23.
//

import SwiftUI
import MapKit

struct Location: Identifiable {
    let id = UUID()
    var title: String
    var coordinate: CLLocationCoordinate2D
}


struct CampsView: View {
    @State private var isMenuOpen: Bool = false
    @State private var searchText = "" // State variable to hold search text
    @State private var locations = [
        Location(title: "Los Angeles", coordinate: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437)),
        Location(title: "New York", coordinate: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060)),
        Location(title: "Indianapolis", coordinate: CLLocationCoordinate2D(latitude: 39.7684, longitude: -86.1581))
    ]
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 39.50, longitude: -98.35), // Geographic center of the contiguous US
        span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25)
    )
    
    
    
    var body: some View {
        ZStack { // Root view
            VStack {
                HamburgerMenu(isMenuOpen: $isMenuOpen)
                    .navigationBarBackButtonHidden(true)
                    .frame(height: 50)
                    .padding(.bottom, 30)
                
                HStack {
                    Text("Find a Camp")
                        .padding(10)
                        .background(Color(hex: "c7972b"))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    NavigationLink(destination: CalendarView()){
                        Text("Calendar")
                            .padding(10)
                            .background(Color(hex: "0f2d53"))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    
                    
                    NavigationLink(destination: CampInfoView()){
                        Text("Camp Info")
                            .padding(10)
                            .background(Color(hex: "0f2d53"))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    
                }
                .padding()
                
                Map(coordinateRegion: $region, annotationItems: locations) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        Image(systemName: "mappin.circle.fill") // Custom image or view
                            .foregroundColor(Color(hex: "c7972b")) // Custom color
                            .imageScale(.large)
                            .background(Color(hex: "0f2d53"))
                            .cornerRadius(20)
                    }
                }
                .mapStyle(.standard)
                .frame(height: 250)
                
                
                Text("FIND A CAMP NEAR YOU").font(.title2).padding()
                
                TextField("Zip Code", text: $searchText)
                    .padding(7)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                Button("Search"){
                    findNearestLocation()
                }
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
                
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
                            print("Hello World")
                        }){
                            Text("Sign Up")
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
                            print("Hello World")
                        }){
                            Text("Sign Up")
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
                            print("Hello World")
                        }){
                            Text("Sign Up")
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
                            print("Hello World")
                        }){
                            Text("Sign Up")
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
            
            // Sliding menu
            if isMenuOpen {
                MenuView(isMenuOpen: $isMenuOpen)
                    .frame(width: UIScreen.main.bounds.width)
                    .transition(.move(edge: .leading))
            }
        }
    }
    
    private func findNearestLocation() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(searchText) { (placemarks, error) in
            if let error = error {
                // Handle the error here (e.g., user entered an invalid zip code)
                print("Geocoding error: \(error.localizedDescription)")
                return
            }
            if let placemark = placemarks?.first, let location = placemark.location {
                self.updateMapToNearestLocation(userLocation: location)
                searchText = ""
            }
        }
    }
    
    private func updateMapToNearestLocation(userLocation: CLLocation) {
        var nearestLocation: Location? = nil
        var smallestDistance: CLLocationDistance?
        
        for location in locations {
            let locationCoordinates = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let distance = userLocation.distance(from: locationCoordinates)
            
            if smallestDistance == nil || distance < smallestDistance! {
                smallestDistance = distance
                nearestLocation = location
            }
        }
        
        if let nearestLocation = nearestLocation {
            withAnimation(.easeInOut(duration: 1.5)) {
                region.center = nearestLocation.coordinate
                region.span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) // Adjust the zoom level as needed
            }
            
        }
        
        
    }
}

#Preview {
    CampsView()
}
