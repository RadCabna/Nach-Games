//
//  SelectMiniGame.swift
//  Nach Games
//
//  Created by Алкександр Степанов on 18.05.2025.
//

import SwiftUI

struct SelectMiniGame: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount = 0
    @AppStorage("miniGameNumber") var miniGameNumber = 1
    @State private var miniGames = Arrays.miniGamesArray
    var body: some View {
        ZStack {
            Background(backgroundNumber: 1)
            Color.black.opacity(0.5).ignoresSafeArea()
            VStack {
                ZStack {
                    Text("MINI GAMES")
                        .font(Font.custom("SigmarOne-Regular", size: screenWidth*0.04))
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 2)
                    HStack {
                        Image("backButton")
                            .resizable()
                            .scaledToFit()
                            .frame(height: screenWidth*0.06)
                            .onTapGesture {
                                coordinator.navigate(to: .gameMode)
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
                    ForEach(0..<miniGames.count, id: \.self) { index in
                    Image("miniGameIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.18)
                            .overlay(
                                VStack {
                                    Text(miniGames[index])
                                        .font(Font.custom("SigmarOne-Regular", size: screenWidth*0.015))
                                        .foregroundColor(.white)
                                        .shadow(color: .black, radius: 2)
                                        .multilineTextAlignment(.center)
                                    MenuButton(size: 0.07, text: "PLAY")
                                }
                                    .frame(maxHeight: .infinity, alignment: .bottom)
                                    .padding(.bottom)
                            )
                            .onTapGesture {
                                miniGameNumber = index + 1
                                goToMiniGame()
                            }
                    }
                }
                Spacer()
            }
        }
    }
    
    func goToMiniGame() {
        switch miniGameNumber {
        case 1:
            coordinator.navigate(to: .miniOne)
        case 2:
            coordinator.navigate(to: .miniTwo)
        case 3:
            coordinator.navigate(to: .miniThree)
        case 4:
            coordinator.navigate(to: .miniFour)
        default:
            coordinator.navigate(to: .miniOne)
        }
    }
    
}

#Preview {
    SelectMiniGame()
}
