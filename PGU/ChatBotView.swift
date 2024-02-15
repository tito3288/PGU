//
//  ChatBotView.swift
//  PGU
//
//  Created by Bryan Arambula on 2/15/24.
//

import SwiftUI

struct ChatBotView: View {
    @ObservedObject var chatBotModel = ChatBotModel()
    @State private var userInput: String = ""
    @State private var chatHistory: [(String, Bool)] = [] // Bool represents if the message is from the user (true) or the bot (false)
    @State private var isBotTyping = false

    
    var body: some View {


            VStack {
                List {
                    ForEach(chatHistory, id: \.0) { chat, isUser in
                        HStack {
                            if isUser {
                                Spacer()
                                Text(chat).foregroundColor(Color(hex: "0f2d53"))
                            } else {
                                Text(chat)                    .foregroundColor(Color(hex: "c7972b"))

                                Spacer()
                            }
                        }
                    }
                    if isBotTyping {
                        HStack {
                            Spacer()
                            Text("Typing...").foregroundColor(.gray)
                            Spacer()
                        }.transition(.opacity) // Optional: add a fade transition
                    }
                }
//                .listStyle(PlainListStyle()) // Removes list lines
//                .background(Color.clear) // Makes list background transparent

                
                
                HStack {
                    TextField("Ask me something...", text: $userInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Send") {
                        sendMessage()
                    }
                    .foregroundColor(Color(hex: "c7972b"))
                }.padding()
                
            }
//            .background(Color.blue.edgesIgnoringSafeArea(.all)) // Sets the entire background to blue, extending to the screen's edges

            .onAppear {
                chatHistory.append(("Is there anything I can help you with?", false))
            }
    }
    
    func sendMessage() {
        guard !userInput.isEmpty else { return }
        
        let userQuestion = userInput // Capture userInput before clearing
        chatHistory.append((userInput, true)) // Append user message
        userInput = "" // Clear input field immediately for better UX

        isBotTyping = true // Start typing indicator

        let delayInSeconds = 2.0 // Adjust the delay as needed
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) {
            // Use userQuestion inside the closure
            if let answer = self.chatBotModel.answer(for: userQuestion) {
                self.chatHistory.append((answer, false))
            } else {
                self.chatHistory.append(("I'm not sure about that. Please email us for more information.", false))
            }
            self.isBotTyping = false // Stop typing indicator
        }
    }


}


#Preview {
    ChatBotView()
}
