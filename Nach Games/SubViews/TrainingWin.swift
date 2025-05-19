//
//  TrainingWin.swift
//  Nach Games
//
//  Created by Алкександр Степанов on 18.05.2025.
//

import SwiftUI

struct TrainingWin: View {
    @AppStorage("coinCount") var coinCount = 0
    @EnvironmentObject var coordinator: Coordinator
    @Binding var trainingWin: Bool
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
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
                            Text("50")
                                .font(Font.custom("SigmarOne-Regular", size: screenWidth*0.03))
                                .foregroundColor(Color("shadowColor"))
                                .shadow(color: .black, radius: 2)
                                .padding(.bottom, screenWidth*0.005)
                        }
                        .padding()
                        MenuButton(size: 0.13, text: "RETRY")
                            .onTapGesture {
                                coinCount += 50
                                trainingWin.toggle()
                            }
                        MenuButton(size: 0.13, text: "MENU")
                            .onTapGesture {
                                coinCount += 50
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
    TrainingWin(trainingWin: .constant(true))
}
