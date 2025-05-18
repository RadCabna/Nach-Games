//
//  GameMode.swift
//  Nach Games
//
//  Created by Алкександр Степанов on 18.05.2025.
//

import SwiftUI

struct GameMode: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount = 0
    @AppStorage("gameMode") var gameMode = 1
    var body: some View {
        ZStack {
            Background(backgroundNumber: 1)
            Color.black.opacity(0.5).ignoresSafeArea()
            VStack {
                ZStack {
                    Text("CHOOSE MODE")
                        .font(Font.custom("SigmarOne-Regular", size: screenWidth*0.04))
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 2)
                    HStack {
                        Image("backButton")
                            .resizable()
                            .scaledToFit()
                            .frame(height: screenWidth*0.06)
                            .onTapGesture {
                                coordinator.navigate(to: .mainMenu)
                            }
                        Spacer()
                        Image("coinCountFrame")
                            .resizable()
                            .scaledToFit()
                            .frame(height: screenWidth*0.06)
                            .overlay(
                                Text("\(coinCount)")
                                    .font(Font.custom("SigmarOne-Regular", size: screenWidth*0.03))
                                    .foregroundColor(Color("shadowColor"))
                                    .offset(x: screenWidth*0.02)
                            )
                    }
                }
                .padding()
                Spacer()
                HStack {
                    ZStack {
                        Image("settingsFrame")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.19)
                        VStack {
                            Text("TRAINING")
                                .font(Font.custom("SigmarOne-Regular", size: screenWidth*0.02))
                                .foregroundColor(.white)
                                .padding(.bottom, screenHeight*0.1)
                            
                            MenuButton(size: 0.1, text: "CHOOSE")
                        }
                        .padding(.bottom)
                    }
                    .onTapGesture {
                        gameMode = 1
                        coordinator.navigate(to: .selectHorse)
                    }
                    ZStack {
                        Image("settingsFrame")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.19)
                        VStack {
                            Text("TOURNAMENT")
                                .font(Font.custom("SigmarOne-Regular", size: screenWidth*0.02))
                                .foregroundColor(.white)
                                .padding(.bottom, screenHeight*0.1)
                            
                            MenuButton(size: 0.1, text: "CHOOSE")
                        }
                        .padding(.bottom)
                    }
                    .onTapGesture {
                        gameMode = 2
                        coordinator.navigate(to: .selectHorse)
                    }
                    ZStack {
                        Image("settingsFrame")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.19)
                        VStack {
                            Text("MINI GAME")
                                .font(Font.custom("SigmarOne-Regular", size: screenWidth*0.02))
                                .foregroundColor(.white)
                                .padding(.bottom, screenHeight*0.1)
                            
                            MenuButton(size: 0.1, text: "CHOOSE")
                        }
                        .padding(.bottom)
                    }
                    .onTapGesture {
                        coordinator.navigate(to: .selectMiniGame)
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    GameMode()
}
