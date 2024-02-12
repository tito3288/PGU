//
//  CoachDrills.swift
//  PGU
//
//  Created by Bryan Arambula on 2/12/24.
//

import SwiftUI
import SwiftUI
import UIKit
import ImageIO


//
//struct GIFImage: UIViewRepresentable {
//    var imageName: String
//
//    func makeUIView(context: Context) -> UIImageView {
//        guard let gifImage = UIImage.gif(name: imageName) else {
//            return UIImageView()
//        }
//        let imageView = UIImageView(image: gifImage)
//        imageView.contentMode = .scaleAspectFit
//
//        // Set up constraints after adding the view to a parent if necessary
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            imageView.widthAnchor.constraint(equalToConstant: 100) // Adjust width directly
//        ])
//
//        return imageView
//    }
//
//    func updateUIView(_ uiView: UIImageView, context: Context) {
//        // Update the view if necessary.
//    }
//}
//
//
//extension UIImage {
//    static func gif(name: String) -> UIImage? {
//        guard let bundleURL = Bundle.main.url(forResource: name, withExtension: "gif") else {
//            return nil
//        }
//        guard let imageData = try? Data(contentsOf: bundleURL) else {
//            return nil
//        }
//        guard let source = CGImageSourceCreateWithData(imageData as CFData, nil) else {
//            return nil
//        }
//        let count = CGImageSourceGetCount(source)
//        var images = [UIImage]()
//        var totalDuration: TimeInterval = 0
//
//        for i in 0..<count {
//            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
//                let propertiesOptions = CGImageSourceCopyPropertiesAtIndex(source, i, nil) as NSDictionary?
//                let gifProperties = propertiesOptions?[kCGImagePropertyGIFDictionary as NSString] as? NSDictionary
//                if let duration = gifProperties?[kCGImagePropertyGIFDelayTime as NSString] as? NSNumber {
//                    totalDuration += duration.doubleValue // Corrected
//                    images.append(UIImage(cgImage: image))
//                }
//            }
//        }
//
//        return UIImage.animatedImage(with: images, duration: totalDuration)
//    }
//}



struct CoachDrills: View {
    
    @State private var isMenuOpen: Bool = false

    var body: some View {
        ZStack{
            VStack {
                
                HamburgerMenu(isMenuOpen: $isMenuOpen)
                    .navigationBarBackButtonHidden(true)
                    .frame(height: 50)
                    .padding(.bottom, 30)
                
//                Spacer()
                
                
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
                    

                        Text("Coach Drills")
                            .padding(10)
                            .frame(minWidth: 0, maxWidth: .infinity) // Flexible frame
                            .background(Color(hex: "c7972b"))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    
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
                
//                    GIFImage(imageName: "coach-drills3")
                
                Spacer()

                Image("coach-drills5")
                    .resizable()
                    .frame(width: 350, height: 350)
                
                Spacer()

     
            }
            

        }
        
        Spacer()
        
        FooterMenu()
        
        if isMenuOpen {
            MenuView(isMenuOpen: $isMenuOpen)
                .frame(width: UIScreen.main.bounds.width)
                .transition(.move(edge: .leading))
        }

    }
    
    
    
}

#Preview {
    CoachDrills()
}
