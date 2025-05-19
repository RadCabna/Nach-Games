//
//  GameWin.swift
//  Nach Games
//
//  Created by Алкександр Степанов on 18.05.2025.
//

import SwiftUI

struct GameWin: View {
    @AppStorage("coinCount") var coinCount = 0
    @EnvironmentObject var coordinator: Coordinator
    @Binding var gameWin: Bool
    var body: some View {
        ZStack {
            Image("settingsFrame")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.29)
                .overlay(
                    VStack(spacing: 0) {
                        Text("YOU WIN")
                            .font(Font.custom("SigmarOne-Regular", size: screenWidth*0.04))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2)
                        HStack {
                            Image("coin")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.02)
                            Text("150")
                                .font(Font.custom("SigmarOne-Regular", size: screenWidth*0.03))
                                .foregroundColor(Color("shadowColor"))
                                .shadow(color: .black, radius: 2)
                                .padding(.bottom, screenWidth*0.005)
                        }
                        .padding()
                        MenuButton(size: 0.13, text: "RETRY")
                            .onTapGesture {
                                coinCount += 150
                                gameWin.toggle()
                            }
                        MenuButton(size: 0.13, text: "MENU")
                            .onTapGesture {
                                coinCount += 150
                                coordinator.navigate(to: .mainMenu)
                            }
                           
                    }
                )
        }
        .onAppear {
            SoundManager.instance.loopSound(sound: "winSound")
        }
    }
}

#Preview {
    GameWin(gameWin: .constant(true))
}
