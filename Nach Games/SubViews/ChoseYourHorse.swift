//
//  Shop.swift
//  Nach Games
//
//  Created by Алкександр Степанов on 15.05.2025.
//

import SwiftUI

struct ChoseYourHorse: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("selectedHorseIndex") var selectedHorseIndex = 0
    @AppStorage("coinCount") var coinCount = 0
    @AppStorage("gameMode") var gameMode = 1
    @State private var horsesArray = Arrays.choseHorseArray
    @State private var horsesNameArray = UserDefaults.standard.array(forKey: "horsesNameArray") as? [String] ?? ["Bruno","Rune","Zephyr","Ash"]
    var body: some View {
        ZStack {
            Background(backgroundNumber: 1)
            VStack {
                ZStack {
                    Text("CHOOSE HORSE")
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
                    ForEach(0..<horsesArray.count, id: \.self) { index in
                        ZStack {
                            Image("settingsFrame")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.19)
                            VStack {
                                Image("shopTypeFrame")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth*0.14)
                                    .overlay(
                                        Text(horsesArray[index].type)
                                            .font(Font.custom("SigmarOne-Regular", size: screenWidth*0.015))
                                            .foregroundColor(.white)
                                            .padding(.bottom, screenHeight*0.015)
                                    )
                                Image(horsesArray[index].image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth*0.12)
                                HStack {
                                    Text(horsesNameArray[index])
                                        .font(Font.custom("SigmarOne-Regular", size: screenWidth*0.02))
                                        .foregroundColor(.white)
                                   
                                }
                                MenuButton(size: 0.1, text: "CHOOSE")
                                    .onTapGesture {
                                        selectedHorseIndex = index
                                        startGame()
                                    }
                            }
                            .padding(.bottom)
                        }
                    }
                }
                Spacer()
            }
        }
    }
    
    func startGame() {
        switch gameMode {
        case 1:
            coordinator.navigate(to: .training)
        default:
            coordinator.navigate(to: .game)
        }
    }
    
}

#Preview {
    ChoseYourHorse()
}
