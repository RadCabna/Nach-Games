//
//  Settings.swift
//  Nach Games
//
//  Created by Алкександр Степанов on 15.05.2025.
//

import SwiftUI

struct Settings: View {
    @AppStorage("soundVolume") var soundVolumeU: Double = 0.5
    @State private var soundVolume: Double = 0.5
    @AppStorage("musicVolume") var musicVolumeU: Double = 0.5
    @State private var musicVolume: Double = 0.5
    @Binding var showSettings: Bool
    var body: some View {
        ZStack {
//            Color.black.opacity(0.5).ignoresSafeArea()
            Background(backgroundNumber: 1)
            Image("backButton")
                .resizable()
                .scaledToFit()
                .frame(height: screenWidth*0.06)
                .onTapGesture {
                    showSettings.toggle()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding()
            Image("settingsFrame")
                .resizable()
                .scaledToFit()
                .frame(height: screenWidth*0.35)
                .overlay(
                    VStack {
                        Text("SETTINGS")
                            .font(Font.custom("SigmarOne-Regular", size: screenWidth*0.03))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2)
                        Text("SOUND")
                            .font(Font.custom("SigmarOne-Regular", size: screenWidth*0.02))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2)
                        ZStack {
                           Image("settingsBar")
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenWidth*0.02)
                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            let dragAmount = value.translation.width / (screenWidth * 16)
                                            soundVolume = min(max(-0.5, soundVolume + dragAmount), 0.5)
                                        }
                                        .onEnded{_ in
                                            soundVolumeU = soundVolume
                                            SoundManager.instance.updateMusicVolume()
                                        }
                                )
                           Image("settingsSlider")
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenWidth*0.015)
                                .offset(x: -screenWidth*0.0 - -screenWidth*0.2*(soundVolume) )

                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            let dragAmount = value.translation.width / (screenWidth * 16)
                                            soundVolume = min(max(-0.5, soundVolume + dragAmount), 0.5)
                                        }
                                        .onEnded{_ in
                                            soundVolumeU = soundVolume
                                            SoundManager.instance.playSound(sound: "soundSettings")
                                        }
                                )
                        }
                        Text("MUSIC")
                            .font(Font.custom("SigmarOne-Regular", size: screenWidth*0.02))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2)
                        ZStack {
                           Image("settingsBar")
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenWidth*0.02)
                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            let dragAmount = value.translation.width / (screenWidth * 16)
                                            musicVolume = min(max(-0.5, musicVolume + dragAmount), 0.5)
                                        }
                                        .onEnded{_ in
                                            musicVolumeU = musicVolume
                                            SoundManager.instance.updateMusicVolume()
                                        }
                                )
                           Image("settingsSlider")
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenWidth*0.015)
                                .offset(x: -screenWidth*0.0 - -screenWidth*0.2*(musicVolume) )

                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            let dragAmount = value.translation.width / (screenWidth * 16)
                                            musicVolume = min(max(-0.5, musicVolume + dragAmount), 0.5)
                                        }
                                        .onEnded{_ in
                                            musicVolumeU = musicVolume
                                            SoundManager.instance.playSound(sound: "soundSettings")
                                        }
                                )
                        }
                        MenuButton(size: 0.12, text: "SAVE")
                            .onTapGesture {
                                showSettings.toggle()
                            }
                    }
                )
        }
        
        .onChange(of: musicVolume) { _ in
            musicVolumeU = musicVolume
            SoundManager.instance.updateMusicVolume()
        }
        
        .onAppear {
            soundVolume = soundVolumeU
            musicVolume = musicVolumeU
        }
        
    }
}

#Preview {
    Settings(showSettings: .constant(true))
}
