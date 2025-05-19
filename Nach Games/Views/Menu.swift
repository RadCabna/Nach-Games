//
//  Menu.swift
//  Nach Games
//
//  Created by Алкександр Степанов on 14.05.2025.
//

import SwiftUI

struct Menu: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount = 0
    @State private var showShop = false
    @State private var showSettings = false
    @State private var showAchievements = false
    var body: some View {
        ZStack {
            Background(backgroundNumber: 1)
            Image("whiteBlur")
                .resizable()
                .scaledToFit()
                .frame(height: screenWidth*0.4)
            Image("menuLogo")
                .resizable()
                .scaledToFit()
                .frame(height: screenWidth*0.2)
            VStack {
                HStack {
                    Image("settingsButton")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenWidth*0.06)
                        .onTapGesture {
                            showSettings.toggle()
                        }
                    Image("achieveButton")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenWidth*0.06)
                        .onTapGesture {
                            showAchievements.toggle()
                        }
                    Spacer()
                    Image("shopButton")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenWidth*0.06)
                        .onTapGesture {
                            showShop.toggle()
                        }
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
                .padding()
                Spacer()
                HStack(spacing: screenWidth*0.05) {
                    MenuButton(size: 0.17, text: "PLAY")
                        .onTapGesture {
                            coordinator.navigate(to: .gameMode)
                        }
//                    MenuButton(size: 0.17, text: "UPGRADE")
                }
            }
            .padding(.bottom)
            
            if showShop {
                Shop(showShop: $showShop)
            }
            if showSettings {
                Settings(showSettings: $showSettings)
            }
            if showAchievements {
                Achievements(showAchievements: $showAchievements)
            }
        }
        
        .onAppear {
            SoundManager.instance.stopAllSounds()
            SoundManager.instance.loopSound(sound: "musicMain")
        }
        
    }
}

#Preview {
    Menu()
}
