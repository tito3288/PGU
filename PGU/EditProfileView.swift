//
//  EditProfileView.swift
//  PGU
//
//  Created by Bryan Arambula on 12/31/23.
//

import SwiftUI

struct EditProfileView: View {
    
    @State private var name: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var membership: String = ""
    
    
    @State private var isImagePickerPresented = false
    @State private var selectedImage: UIImage? = nil
    


    
    var body: some View {
        
        Image("logo").resizable().scaledToFit().frame(width: 240, height: 90)
        
        Spacer()
        
        VStack{
            
            Text("EDIT PROFILE")
                .padding()
                .font(.title)
                .fontWeight(.bold)
            
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFill() // Ensures the image fills the frame
                    .frame(width: 90, height: 90) // Set the same size as your person.fill icon
                    .clipShape(Circle()) // Makes the image round
                    .overlay(Circle().stroke(Color(hex: "c7972b"), lineWidth: 2))
                // additional styling if needed
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding(30)
                    .foregroundColor(.white)
                    .background(Circle().fill(Color(hex: "c7972b")))
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color(hex: "c7972b"), lineWidth: 2))
                // styling for the default image
            }
                
            
            Text("Edit Photo")
                .foregroundColor(.gray)
                .onTapGesture {
                    self.isImagePickerPresented = true
                }

            Group {
                HStack {
                    Text("Full Name")
                        .frame(width: 110, alignment: .leading) // Fixed width
                        .fontWeight(.bold)

                    TextField("Enter your name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                  
                }
                
                HStack {
                    Text("Email")
                        .frame(width: 110, alignment: .leading) // Fixed width
                        .fontWeight(.bold)

                    TextField("Enter your email", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack {
                    
                    Text("Password")
                        .frame(width: 110, alignment: .leading) // Fixed width
                        .fontWeight(.bold)

                    SecureField("Enter your password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack {
                    
                    Text("Phone Number")
                        .frame(width: 110, alignment: .leading) // Fixed width
                        .fontWeight(.bold)

                    SecureField("Enter your number", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
//
//                HStack {
//                    Text("Membership")
//                        .frame(width: 110, alignment: .leading) // Fixed width
//                        .fontWeight(.bold)
//
//                    TextField("Enter your membership type", text: $membership)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                }
            }
            
            .padding()
            
        }
        .onAppear {
            self.selectedImage = self.loadImage()
            
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(selectedImage: $selectedImage, isPresented: $isImagePickerPresented)
                .onDisappear {
                    if let selectedImage = selectedImage {
                        saveImage(selectedImage)
                    }
                }
        }
        
        Spacer()
        
        FooterMenu()

        
    }
    
    
    func saveImage(_ image: UIImage) {
        if let data = image.jpegData(compressionQuality: 1) ?? image.pngData() {
            let filename = getDocumentsDirectory().appendingPathComponent("savedImage.png")
            try? data.write(to: filename)
            
            UserDefaults.standard.set(filename.path, forKey: "savedImagePath")
        }
    }
    
    func loadImage() -> UIImage? {
        if let path = UserDefaults.standard.string(forKey: "savedImagePath"),
           let imageData = FileManager.default.contents(atPath: path) {
            return UIImage(data: imageData)
        }
        return nil
    }
    
    func resetImage() {
        UserDefaults.standard.removeObject(forKey: "savedImagePath")
        selectedImage = nil
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}
   


struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var isPresented: Bool

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }

            parent.isPresented = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false
        }
    }
}

#Preview {
    EditProfileView()
}
