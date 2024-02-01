//
//  InboxView.swift
//  PGU
//
//  Created by Bryan Arambula on 12/4/23.
//

import SwiftUI
import CoreData

struct InboxView: View {

    @State private var isMenuOpen: Bool = false

    //MARK: LOGIC TO DISPLAY FCM NOTIFICATION ON THE INBOXVIEW
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Notifi.title, ascending: true)],
        animation: .default)
    
    private var notifications: FetchedResults<Notifi>
    
    var body: some View {
        ZStack {
            VStack {
                HamburgerMenu(isMenuOpen: $isMenuOpen)
                    .navigationBarBackButtonHidden(true)
                    .frame(height: 50)
                    .padding(.bottom, 30)
                
                Text("INBOX")
                    .font(.title)
                    .fontWeight(.bold)
                
                List {
                    ForEach(notifications, id: \.self) { notification in
                        VStack(alignment: .leading, spacing: 0) {
                            Text(notification.title ?? "Unknown Title")
                                .font(.title2)
                                .foregroundColor(Color(hex: "c7972b"))
                                .fontWeight(.bold)
                            
                            Text(notification.body ?? "No content")
                                .font(.body)
                        }
                    }
                    .onDelete(perform: deleteNotifications)
                }
                .listStyle(PlainListStyle())
                
                
                //THIS IS THE CHAT ICON
                HStack{
                    Spacer()
                    Button(action: {
                        print("Chat icon pressed")
                    }, label: {
                        Image("chat-icon")
                            .padding()
                    })
                    
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
            
            
            //MARK: LOGIC FOR THE SLIDING MENU.
            if isMenuOpen {
                MenuView(isMenuOpen: $isMenuOpen)
                    .frame(width: UIScreen.main.bounds.width)
                    .transition(.move(edge: .leading))
                    .zIndex(1) // Ensure the menu is on top
            }
        }
  
    }
    

    
    //MARK: LOGIC TO DELETE NOTIFICATIOMN FROM USERS DEVICE AND CORE DATA.
    private func deleteNotifications(offsets: IndexSet) {
        withAnimation {
            offsets.map { notifications[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    
}

#Preview {
    InboxView()
}
