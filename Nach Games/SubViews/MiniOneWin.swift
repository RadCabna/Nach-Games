//
//  MiniOneWin.swift
//  Nach Games
//
//  Created by Алкександр Степанов on 18.05.2025.
//

import SwiftUI

struct MiniOneWin: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount = 0
    @Binding var miniOneWin: Bool
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            Image("settingsFrame")
                .resizable()
                .scaledToFit()
                .frame(height: screenWidth*0.35)
                .overlay(
                    VStack {
                        VStack(spacing: 0) {
                            Text("YOU WIN")
                                .font(Font.custom("SigmarOne-Regular", size: screenWidth*0.04))
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 2)
                                .padding(.bottom)
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
                            MenuButton(size: 0.13, text: "RETRY")
                                .onTapGesture {
                                    coinCount += 50
                                    miniOneWin.toggle()
                                }
                            MenuButton(size: 0.13, text: "MENU")
                                .onTapGesture {
                                    coinCount += 50
                                    coordinator.navigate(to: .mainMenu)
                                }
                               
                        }
                    }
                )
            
        }
    }
}

#Preview {
    MiniOneWin(miniOneWin: .constant(true))
}
