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
        Location(title: "Dodge City High School, Dodge City, KS", coordinate: CLLocationCoordinate2D(latitude: 37.78280790545586,  longitude: -100.04471873960134)),
        Location(title: "Limon Public High School, Limon, CO", coordinate: CLLocationCoordinate2D(latitude: 39.27026120527985, longitude: -103.68905270774891)),
        Location(title: "Max Jones Fieldhouse, Goodland, KS", coordinate: CLLocationCoordinate2D(latitude: 39.34647640261924 , longitude: -101.70298283866518)),
        Location(title: "Canton-Galva Jr/Sr High School, Canton, KS", coordinate: CLLocationCoordinate2D(latitude: 38.381116853763004,  longitude: -97.4329804335779)),
        Location(title: "MSA Fieldhouse , Grand Rapids, MI", coordinate: CLLocationCoordinate2D(latitude: 42.917661227497916,  longitude: -85.53149132077283))
        ,Location(title: "Legacy Courts, Lafayette, IN", coordinate: CLLocationCoordinate2D(latitude: 40.45102926168622,  longitude: -86.85728886332116))
        ,Location(title: "IUSB Student Activities Center, South Bend, IN", coordinate: CLLocationCoordinate2D(latitude: 41.664600041689056,  longitude: -86.2199390073205))
        ,Location(title: "Hornell Senior High School, Hornell, NY", coordinate: CLLocationCoordinate2D(latitude: 42.33385628960623,  longitude: -77.66308146371362))
        ,Location(title: "Victor Central School District, Rochester, NY", coordinate: CLLocationCoordinate2D(latitude: 42.987372153832325,  longitude: -77.41357237793102))

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
                    
                        Text("Find Camps")
                            .padding(10)
                            .frame(minWidth: 0, maxWidth: .infinity) // Flexible frame
                            .background(Color(hex: "c7972b"))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))

                    Spacer() // Spacing between buttons

                    NavigationLink(destination: CalendarView()) {
                        Text("Calendar")
                            .padding(10)
                            .frame(minWidth: 0, maxWidth: .infinity) // Flexible frame
                            .background(Color(hex: "0f2d53"))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }

                    Spacer() // Spacing between buttons

                    NavigationLink(destination: CampInfoView()) {
                        Text("Camp Info")
                            .padding(10)
                            .frame(minWidth: 0, maxWidth: .infinity) // Flexible frame
                            .background(Color(hex: "0f2d53"))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
                .padding()
                
                
                Map(coordinateRegion: $region, annotationItems: locations) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        Button(action: {
                            openMapForDirections(to: location)
                        }) {
                            VStack {
                                Text(location.title)  // Always display the title for testing
                                    .font(.caption)
                                    .padding(5)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 3)
                                Image(systemName: "mappin.circle.fill")
                                    .foregroundColor(Color(hex: "c7972b"))
                                    .imageScale(.large)
                                    .background(Color(hex: "0f2d53"))
                                    .cornerRadius(20)
                            }
                        }
                    }
                }
                .mapStyle(.standard)
                .frame(height: 250)
                
                
                Text("FIND A CAMP NEAR YOU")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(Color(hex: "0f2d53"))

                
                
                HStack{
                    
                    TextField("Zip Code", text: $searchText)
                        .padding(7)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.leading)
//                        .padding(.horizontal)
                    
                    Button(action:{
                        findNearestLocation()

                    }){
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color(hex: "0f2d53"))
                    }
                    .padding(7)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.trailing)
                    
                }
                
                
                List{
                    HStack{
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Dodge City, KS")
                                .font(.title2) // Style for regular text
                                .onTapGesture {
                                    zoomToLocation(Location(title: "Dodge City High School, Dodge City, KS", coordinate: CLLocationCoordinate2D(latitude: 37.78280790545586, longitude: -100.04471873960134)))
                                }
                            Text("May 28th- May 31st, 2024")
                                .font(.body) // Style for title text
                        }
                        
                        Spacer()
                        
                        Button(action: {
                           print("Sign Up")
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
                            Text("Limon, CO")
                                .font(.title2) // Style for regular text
                                .onTapGesture {
                                    zoomToLocation(Location(title: "Limon Public High School, Limon, CO", coordinate: CLLocationCoordinate2D(latitude: 39.27026120527985, longitude: -103.68905270774891)))
                                }
                            Text("June 3rd- June 6th, 2024")
                                .font(.body) // Style for title text
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            print("Sign Up")
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
                            Text("Goodland, KS")
                                .font(.title2) // Style for regular text
                                .onTapGesture {
                                zoomToLocation(Location(title: "Max Jones Fieldhouse, Goodland, KS", coordinate: CLLocationCoordinate2D(latitude: 39.34647640261924 , longitude: -101.70298283866518)))
                            }
                            Text("June 10th- June 13th, 2024")
                                .font(.body) // Style for title text
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            print("Sign Up")
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
                            Text("Canton, KS")
                                .font(.title2) // Style for regular text
                                .onTapGesture {
                                    zoomToLocation(Location(title: "Canton-Galva Jr/Sr High School, Canton, KS", coordinate: CLLocationCoordinate2D(latitude: 38.381116853763004,  longitude: -97.4329804335779)))

                                }
                            Text("June 17th- June 20th, 2024")
                                .font(.body) // Style for title text
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            print("Sign Up")
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
                            Text("Grand Rapids, MI")
                                .font(.title2) // Style for regular text
                                .onTapGesture {
                                    zoomToLocation(Location(title: "MSA Fieldhouse , Grand Rapids, MI", coordinate: CLLocationCoordinate2D(latitude: 42.917661227497916,  longitude: -85.53149132077283)))
                                }
                            Text("June 17th- June 20th, 2024")
                                .font(.body) // Style for title text
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            print("Sign Up")
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
                            Text("Lafayette, IN")
                                .font(.title2) // Style for regular text
                                .onTapGesture {
                                    zoomToLocation(Location(title: "Legacy Courts, Lafayette, IN", coordinate: CLLocationCoordinate2D(latitude: 40.45102926168622,  longitude: -86.85728886332116)))
                                }
                            Text("June 24th- June 27th, 2024")
                                .font(.body) // Style for title text
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            print("Sign Up")
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
                            Text("South Bend, IN")
                                .font(.title2) // Style for regular text
                                .onTapGesture {
                                    zoomToLocation(Location(title: "IUSB Student Activities Center, South Bend, IN", coordinate: CLLocationCoordinate2D(latitude: 41.664600041689056,  longitude: -86.2199390073205)))
                                }
                            Text("July 8th- July 11th, 2024")
                                .font(.body) // Style for title text
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            print("Sign Up")
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
                            Text("Hornell, NY")
                                .font(.title2) // Style for regular text
                                .onTapGesture {
                                    zoomToLocation(Location(title: "Hornell Senior High School, Hornell, NY", coordinate: CLLocationCoordinate2D(latitude: 42.33385628960623,  longitude: -77.66308146371362)))
                                }
                            Text("July 22nd- July 25th, 2024")
                                .font(.body) // Style for title text
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            print("Sign Up")
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
                            Text("Rochester, NY")
                                .font(.title2) // Style for regular text
                                .onTapGesture {
                                    zoomToLocation(Location(title: "Victor Central School District, Rochester, NY", coordinate: CLLocationCoordinate2D(latitude: 42.987372153832325,  longitude: -77.41357237793102)))
                                }
                            Text("July 29- August 1st, 2024")
                                .font(.body) // Style for title text
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            print("Sign Up")
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

//                    NavigationLink(destination: CampsView()) {
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
//                    }

                        
                    
                    Spacer()
                    
                    NavigationLink(destination: ResourcesView()) {

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
                        
                    }

                    Spacer()

                }
                .padding(.top)
                .background(Color.white)
                
                
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
    
    private func zoomToLocation(_ location: Location) {
        withAnimation(.easeInOut) {
            region.center = location.coordinate
            region.span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01) // Adjust zoom level as needed
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
    
    private func openMapForDirections(to location: Location) {
        let destinationCoordinate = location.coordinate
        let placemark = MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = location.title

        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMaps(launchOptions: launchOptions)
    }

}

#Preview {
    CampsView()
}
