//
//  MiniThree.swift
//  Nach Games
//
//  Created by Алкександр Степанов on 18.05.2025.
//

import SwiftUI

struct MiniThree: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount = 0
    @State private var youWin = false
    @State private var youLose = false
    @State private var gameTwoArray = Arrays.gameTwoArray
    @State private var stepNumber = 0
    @State private var yourArray = ["emptyRectangle","emptyRectangle","emptyRectangle"]
    var body: some View {
        ZStack {
            Background(backgroundNumber: 1)
            VStack {
                ZStack {
                    Text("MEMORY AID")
                        .font(Font.custom("SigmarOne-Regular", size: screenWidth*0.035))
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
                Image("gameFrameLongRectangle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.58)
                    .overlay(
                        VStack {
                            HStack {
                                ForEach(0..<3, id: \.self) { item in
                                    ZStack {
                                        Image("emptyRectangle")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: screenWidth*0.06)
                                        if yourArray[item] != "emptyRectangle" {
                                            Image(yourArray[item])
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: screenWidth*0.02)
                                        }
                                    }
                                }
                            }
                            .padding(.bottom)
                            HStack {
                                ForEach(0..<4, id: \.self) { item in
                                    if gameTwoArray[item].turn {
                                        ZStack {
                                            Image("openRect")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: screenWidth*0.1)
                                            Image(gameTwoArray[item].image)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(maxWidth: screenWidth*0.03)
                                        }
                                    } else {
                                        ZStack {
                                            Image("closeRect")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: screenWidth*0.1)
                                        }
                                        .onTapGesture {
                                            tapOnRactangle(index: item)
                                        }
                                    }
                                }
                            }
                            HStack {
                                ForEach(4..<8, id: \.self) { item in
                                    if gameTwoArray[item].turn {
                                        ZStack {
                                            Image("openRect")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: screenWidth*0.1)
                                            Image(gameTwoArray[item].image)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(maxWidth: screenWidth*0.03)
                                        }
                                    } else {
                                        ZStack {
                                            Image("closeRect")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: screenWidth*0.1)
                                        }
                                        .onTapGesture {
                                            tapOnRactangle(index: item)
                                        }
                                    }
                                }
                            }
                        }
                    )
            }
            
            if youLose {
                MiniOneLose(miniOneLose: $youLose)
            }
            
        }
        
        .onAppear {
            rotateCards()
        }
        
        .onChange(of: stepNumber) { _ in
        if stepNumber >= 3 {
                youLose = true
            }
        }
        
        .onChange(of: youLose) { _ in
            if !youLose {
                resetLevel()
            }
        }
        
    }
    
    func resetLevel() {
        stepNumber = 0
        yourArray = ["emptyRectangle","emptyRectangle","emptyRectangle"]
        gameTwoArray = Arrays.gameTwoArray.shuffled()
        rotateCards()
    }
    
    func rotateCards() {
        var delay: CGFloat = 0
        for i in 0..<gameTwoArray.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation() {
                    gameTwoArray[i].turn.toggle()
                }
            }
            delay += 0.1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            delay = 0
            for i in 0..<gameTwoArray.count {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    withAnimation() {
                        gameTwoArray[i].turn.toggle()
                    }
                }
                delay += 0.1
            }
        }
    }
    
    func tapOnRactangle(index: Int) {
        if stepNumber < 3 {
            gameTwoArray[index].turn = true
            yourArray[stepNumber] =  gameTwoArray[index].image
            stepNumber += 1
        }
    }
    
}

#Preview {
    MiniThree()
}
