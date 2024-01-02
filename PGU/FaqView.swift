//
//  FaqView.swift
//  PGU
//
//  Created by Bryan Arambula on 12/29/23.
//

import SwiftUI

struct FaqView: View {
    
    @State private var expanded1: Bool = false
    @State private var expanded2: Bool = false
    @State private var expanded3: Bool = false
    @State private var expanded4: Bool = false
    @State private var expanded5: Bool = false
    @State private var expanded6: Bool = false
    @State private var expanded7: Bool = false
    @State private var expanded8: Bool = false
    
    var body: some View {
        ZStack {
            Color(hex: "0f2d53").edgesIgnoringSafeArea(.all)
            
            
            VStack{
                Text("FAQ")
                    .font(.largeTitle) // You can customize the font as needed
                    .foregroundColor(.white)
                    .padding(.top)
            List {
                Group {
                    VStack{
                        HStack{
                            //                        Spacer()
                            Text("Question").font(.title2).padding()
                            Spacer()
                            
                            Button(action: {
                                self.expanded1.toggle()
                                print("Button for Week  tapped")
                            }) {
                                Image(systemName: "chevron.down") // Your button text
                                    .frame(alignment: .trailing)
                                    .padding(10)
                                    .background(Color(hex: "c7972b"))
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                            }
                            .padding(10)
                        }
                        .listRowBackground(Color(hex: "0f2d53"))
                        .listRowInsets(EdgeInsets())
                        
                        if expanded1 {
                            Text("Additional content goes here.")
                                .padding()
                                .transition(.slide)
                        }
                    }
                    
                    
                    VStack{
                        HStack{
                            //                        Spacer()
                            Text("Question").font(.title2).padding()
                            Spacer()
                            
                            Button(action: {
                                self.expanded2.toggle()
                                print("Button for Week  tapped")
                            }) {
                                Image(systemName: "chevron.down") // Your button text
                                    .frame(alignment: .trailing)
                                    .padding(10)
                                    .background(Color(hex: "c7972b"))
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                            }
                            .padding(10)
                        }
                        .listRowBackground(Color(hex: "0f2d53"))
                        .listRowInsets(EdgeInsets())
                        
                        if expanded2 {
                            Text("Additional content goes here.")
                                .padding()
                                .transition(.slide)
                        }
                    }
                    
                    VStack{
                        HStack{
                            //                        Spacer()
                            Text("Question").font(.title2).padding()
                            Spacer()
                            
                            Button(action: {
                                self.expanded3.toggle()
                                print("Button for Week  tapped")
                            }) {
                                Image(systemName: "chevron.down") // Your button text
                                    .frame(alignment: .trailing)
                                    .padding(10)
                                    .background(Color(hex: "c7972b"))
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                            }
                            .padding(10)
                        }
                        .listRowBackground(Color(hex: "0f2d53"))
                        .listRowInsets(EdgeInsets())
                        
                        if expanded3 {
                            Text("Additional content goes here.")
                                .padding()
                                .transition(.slide)
                        }
                    }
                    
                    VStack{
                        HStack{
                            //                        Spacer()
                            Text("Question").font(.title2).padding()
                            Spacer()
                            
                            Button(action: {
                                self.expanded4.toggle()
                                print("Button for Week  tapped")
                            }) {
                                Image(systemName: "chevron.down") // Your button text
                                    .frame(alignment: .trailing)
                                    .padding(10)
                                    .background(Color(hex: "c7972b"))
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                            }
                            .padding(10)
                        }
                        .listRowBackground(Color(hex: "0f2d53"))
                        .listRowInsets(EdgeInsets())
                        
                        if expanded4 {
                            Text("Additional content goes here.")
                                .padding()
                                .transition(.slide)
                        }
                    }
                    
                    VStack{
                        HStack{
                            //                        Spacer()
                            Text("Question").font(.title2).padding()
                            Spacer()
                            
                            Button(action: {
                                self.expanded5.toggle()
                                print("Button for Week  tapped")
                            }) {
                                Image(systemName: "chevron.down") // Your button text
                                    .frame(alignment: .trailing)
                                    .padding(10)
                                    .background(Color(hex: "c7972b"))
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                            }
                            .padding(10)
                        }
                        .listRowBackground(Color(hex: "0f2d53"))
                        .listRowInsets(EdgeInsets())
                        
                        if expanded5 {
                            Text("Additional content goes here.")
                                .padding()
                                .transition(.slide)
                        }
                    }
                    
                    VStack{
                        HStack{
                            //                        Spacer()
                            Text("Question").font(.title2).padding()
                            Spacer()
                            
                            Button(action: {
                                self.expanded6.toggle()
                                print("Button for Week  tapped")
                            }) {
                                Image(systemName: "chevron.down") // Your button text
                                    .frame(alignment: .trailing)
                                    .padding(10)
                                    .background(Color(hex: "c7972b"))
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                            }
                            .padding(10)
                        }
                        .listRowBackground(Color(hex: "0f2d53"))
                        .listRowInsets(EdgeInsets())
                        
                        if expanded6 {
                            Text("Additional content goes here.")
                                .padding()
                                .transition(.slide)
                        }
                    }
                    
                    VStack{
                        HStack{
                            //                        Spacer()
                            Text("Question").font(.title2).padding()
                            Spacer()
                            
                            Button(action: {
                                self.expanded7.toggle()
                                print("Button for Week  tapped")
                            }) {
                                Image(systemName: "chevron.down") // Your button text
                                    .frame(alignment: .trailing)
                                    .padding(10)
                                    .background(Color(hex: "c7972b"))
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                            }
                            .padding(10)
                        }
                        .listRowBackground(Color(hex: "0f2d53"))
                        .listRowInsets(EdgeInsets())
                        
                        if expanded7 {
                            Text("Additional content goes here.")
                                .padding()
                                .transition(.slide)
                        }
                    }
                    
                    VStack{
                        HStack{
                            //                        Spacer()
                            Text("Question").font(.title2).padding()
                            Spacer()
                            
                            Button(action: {
                                self.expanded8.toggle()
                                print("Button for Week  tapped")
                            }) {
                                Image(systemName: "chevron.down") // Your button text
                                    .frame(alignment: .trailing)
                                    .padding(10)
                                    .background(Color(hex: "c7972b"))
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                            }
                            .padding(10)
                        }
                        .listRowBackground(Color(hex: "0f2d53"))
                        .listRowInsets(EdgeInsets())
                        
                        if expanded8 {
                            Text("Additional content goes here.")
                                .padding()
                                .transition(.slide)
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .center) // Center text in each row
                .background(Color.white)
                .cornerRadius(25)
                .listRowInsets(EdgeInsets())
                .padding(.horizontal)
                .padding(.bottom)
                .listRowBackground(Color.clear)
                
            }
            .listStyle(PlainListStyle())
            .padding(.top, 30)
            .background(Color(hex: "0f2d53"))
            .edgesIgnoringSafeArea(.all) // Ignore safe areas to extend to the top and bottom of the screen
            }
        }

    }
}

#Preview {
    FaqView()
}
