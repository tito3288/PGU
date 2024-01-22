//
//  SignUpView.swift
//  PGU
//
//  Created by Bryan Arambula on 12/31/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseAnalytics


struct SignUpView: View {
    
//    @State private var searchText1 = "" // State variable to hold search text
//    @State private var searchText2 = "" // State variable to hold search text
    
    @State private var selectedLocation = "Location" // Default text

    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @State private var isAuthenticated = false

    @State private var name = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    @State private var password = ""
    

    var body: some View {
        VStack{
            
            if isAuthenticated {
                HomeView() // Navigate to ContentView if authenticated
            } else {
                
                Spacer()
                
                Image("logo")
                    .resizable() // Allows the image to be resized
                    .scaledToFit() // Maintains the aspect ratio of the image
                // Specify the desired width and height
                    .frame(width: 200, height: 200)
                
                TextField("Full Name", text: $name)
                    .padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 50)) // Adjust left padding
                    .background(.white)
                    .foregroundColor(Color(hex: "0f2d53"))
                    .font(.body)
                    .bold()
                    .cornerRadius(37)
                    .frame(width: 300) // Set a specific width
                    .overlay(
                        RoundedRectangle(cornerRadius: 37)
                            .stroke(Color(hex: "0f2d53"), lineWidth: 2) // Customize border color and line width
                    )
                
                
                TextField("Email", text: $email)
                    .padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 50)) // Adjust left padding
                    .background(.white)
                    .foregroundColor(Color(hex: "0f2d53"))
                    .font(.body)
                    .bold()
                    .cornerRadius(37)
                    .frame(width: 300) // Set a specific width
                    .overlay(
                        RoundedRectangle(cornerRadius: 37)
                            .stroke(Color(hex: "0f2d53"), lineWidth: 2) // Customize border color and line width
                    )
                    .padding(.top, 15)
                
                TextField("Phone Number", text: $phoneNumber)
                    .padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 50)) // Adjust left padding
                    .background(.white)
                    .foregroundColor(Color(hex: "0f2d53"))
                    .font(.body)
                    .bold()
                    .cornerRadius(37)
                    .frame(width: 300) // Set a specific width
                    .overlay(
                        RoundedRectangle(cornerRadius: 37)
                            .stroke(Color(hex: "0f2d53"), lineWidth: 2) // Customize border color and line width
                    )
                    .padding(.top, 15)
                
                SecureField("Password", text: $password)
                    .padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 50)) // Adjust left padding
                    .background(.white)
                    .foregroundColor(Color(hex: "0f2d53"))
                    .font(.body)
                    .bold()
                    .cornerRadius(37)
                    .frame(width: 300) // Set a specific width
                    .overlay(
                        RoundedRectangle(cornerRadius: 37)
                            .stroke(Color(hex: "0f2d53"), lineWidth: 2) // Customize border color and line width
                    )
                    .padding(.top, 15)
                
                
                
                //********
                
                HStack {
                    Text(selectedLocation)
                    Spacer()
                    
                    Menu {
                        Button("Dodge City, KS", action: {
                            selectedLocation = "Dodge City, KS"
                            Analytics.setUserProperty(selectedLocation, forName: "location_preference")
                        })
                        Button("Limon, CO", action: { selectedLocation = "Limon, CO"
                            Analytics.setUserProperty(selectedLocation, forName: "location_preference")
                        })
                        Button("Goodland, KS", action: { selectedLocation = "Goodland, KS"
                            Analytics.setUserProperty(selectedLocation, forName: "location_preference")
                        })
                        Button("Canton, KS", action: { selectedLocation = "Canton, KS"
                            Analytics.setUserProperty(selectedLocation, forName: "location_preference")
                        })
                        Button("Grand Rapids, MI", action: { selectedLocation = "Grand Rapids, MI"
                            Analytics.setUserProperty(selectedLocation, forName: "location_preference")
                        })
                        Button("Lafayette, IN", action: { selectedLocation = "Lafayette, IN"
                            Analytics.setUserProperty(selectedLocation, forName: "location_preference")
                        })
                        Button("South Bend, IN", action: { selectedLocation = "South Bend, IN"
                            Analytics.setUserProperty(selectedLocation, forName: "location_preference")
                        })
                        Button("Hornell, NY", action: { selectedLocation = "Hornell, NY"
                            Analytics.setUserProperty(selectedLocation, forName: "location_preference")
                        })
                        Button("Rochester, NY", action: { selectedLocation = "Rochester, NY"
                            Analytics.setUserProperty(selectedLocation, forName: "location_preference")
                        })

                    } label: {
                        Image(systemName: "chevron.down") // Your button text
                            .frame(alignment: .trailing)
                            .padding(9)
                            .background(Color(hex: "c7972b"))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 15)) // Adjust left padding
                .background(.white)
                .foregroundColor(Color(hex: "0f2d53"))
                .font(.body)
                .bold()
                .cornerRadius(37)
                .frame(width: 300) // Set a specific width
                .overlay(
                    RoundedRectangle(cornerRadius: 37)
                        .stroke(Color(hex: "0f2d53"), lineWidth: 2) // Customize border color and line width
                )
                .padding(.top, 15)
                
                
                
                Spacer()
                
                Button(action: {
                    // Validate email and password before attempting to sign up
                    print("Create Account button pressed")

                    if !isValidEmail(email) {
                        alertMessage = "Please enter a valid email address."
                        showAlert = true
                        print("Invalid email")

                    } else if !isValidPassword(password) {
                        alertMessage = "Password should be at least 6 characters long."
                        showAlert = true
                        print("Invalid password")

                    } else {
                        signUpUser(email: email, password: password)
                        updateDisplayName(name: name)
                    }
                }) {
                    Text("Create Account")
                    // ... Button styling
                }            .padding(EdgeInsets(top: 15, leading: 50, bottom: 15, trailing: 50))
                    .background(Color(red: 0.78, green: 0.592, blue: 0.169))
                    .foregroundColor(.white)
                    .font(.title3)
                    .bold()
                    .cornerRadius(37)
                    .padding()
                
                
            }
            
            
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Successful"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    
    
    
    //MARK: LOGIC TO SIGN UP USERS USING FIREBASE AUTHENTICATION
    func signUpUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                alertMessage = error.localizedDescription
                showAlert = true
            } else {
                alertMessage = "Account created successfully."
                showAlert = true
                
                Analytics.logEvent(AnalyticsEventSignUp, parameters: [
                    AnalyticsParameterMethod: "Email"
                ])
                
                // Log the event with Firebase Analytics
                Analytics.logEvent("signup_location", parameters: [
                    "location": selectedLocation
                ])
                
                Analytics.setUserProperty(selectedLocation, forName: "location_preference")

                
                if let userId = authResult?.user.uid {
                    saveUserDataToFirestore(userId: userId, name: name, email: email, phoneNumber: phoneNumber, location: selectedLocation)
                }

                // Delay navigation to allow the user to read the message
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    isAuthenticated = true
                }
            }
        }
    }
    
    
    
    //MARK: LOGIC FOR SAVING INPUTS TO FIRESTORE
    func saveUserDataToFirestore(userId: String, name: String, email: String, phoneNumber: String, location: String) {
        let db = Firestore.firestore()
        let userData: [String: Any] = [
            "name": name,
            "email": email,
            "phoneNumber": phoneNumber,
            "location": location
        ]

        db.collection("users").document(userId).setData(userData) { error in
            if let error = error {
                print("Error saving user data to Firestore: \(error)")
                // Handle the error appropriately
            } else {
                print("User data saved successfully to Firestore")
            }
        }
    }


    
    //MARK: FIGURE OUT WHAT THIS ABOUT?????*****
    func updateDisplayName(name: String) {
        if let user = Auth.auth().currentUser {
            print("Display Name: \(user.displayName ?? "No name")")

            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = name
            changeRequest.commitChanges { error in
                if let error = error {
                    print("Error updating display name: \(error.localizedDescription)")
                    // Optionally handle the error (e.g., show an alert)
                } else {
                    print("Display name updated successfully")
                    // Continue with the navigation or other actions
                }
            }
        }
    }

    
    
    
    //MARK: LOGIC FOR EMAIL AND PASSWORD COMDITIONS
    func isValidEmail(_ email: String) -> Bool {
        // Simple regex for email validation
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }

    func isValidPassword(_ password: String) -> Bool {
        // Example: Check if the password is at least 6 characters long
        return password.count >= 6
    }
 
}



#Preview {
    SignUpView()
}
