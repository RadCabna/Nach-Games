//
//  MiniTwo.swift
//  Nach Games
//
//  Created by Алкександр Степанов on 18.05.2025.
//

import SwiftUI

struct MiniTwo: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount = 0
    @State private var timer: Timer? = nil
    @State private var elapsedTime = 60
    @State private var youWin = false
    @State private var youLose = false
    @State private var gameTwoArray = Arrays.gameTwoArray
    @State private var yourAnswer = [0,0,0,0]
    @State private var tapCount = 0
    @State private var stepNumber = 0
    @State private var firstIndex = 0
    @State private var secondIndex = 0
    var body: some View {
        ZStack {
            Background(backgroundNumber: 1)
            VStack {
                ZStack {
                    Text("FIND A PAIR")
                        .font(Font.custom("SigmarOne-Regular", size: screenWidth*0.035))
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 2)
                    HStack {
                        Image("backButton")
                            .resizable()
                            .scaledToFit()
                            .frame(height: screenWidth*0.06)
                            .onTapGesture {
                                coordinator.navigate(to: .selectMiniGame)
                            }
                        
                        Image("timerFrame")
                            .resizable()
                            .scaledToFit()
                            .frame(height: screenWidth*0.06)
                            .overlay(
                                HStack {
                                    Image("clock")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: screenWidth*0.03)
                                    Text(timeString(time: elapsedTime))
                                        .font(Font.custom("SigmarOne-Regular", size: screenWidth*0.03))
                                        .foregroundColor(.white)
                                        .padding(.bottom, screenHeight*0.005)
                                }
                            )
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
                                ForEach(0..<yourAnswer.count, id: \.self) { item in
                                    Image("emptyRectangle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: screenWidth*0.06)
                                        .overlay(
                                            ZStack {
                                                if yourAnswer[item] == 1 {
                                                  Image("okMark")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: screenWidth*0.03)
                                                }
                                                if yourAnswer[item] == 2 {
                                                    Image("wrongMark")
                                                          .resizable()
                                                          .scaledToFit()
                                                          .frame(width: screenWidth*0.03)
                                                }
                                                
                                            }
                                        )
                                }
                            }
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
                                            tapOnCard(index: item)
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
                                            tapOnCard(index: item)
                                        }
                                    }
                                }
                            }
                            HStack {
                                ForEach(8..<12, id: \.self) { item in
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
                                            tapOnCard(index: item)
                                        }
                                    }
                                }
                            }
                        }
                    )
                Spacer()
            }
            
            if youLose {
                MiniOneLose(miniOneLose: $youLose)
            }
            if youWin {
                MiniOneWin(miniOneWin: $youWin)
            }
            
        }
        
        .onAppear {
            startTimer()
        }
        
        .onChange(of: stepNumber) { _ in
            if stepNumber == 4 {
                stopTimer()
                youLose = true
            }
        }
        
        .onChange(of: youLose) { _ in
        if !youLose {
                restartLevel()
            }
        }
        
    }
    
    func restartLevel() {
        elapsedTime = 60
        startTimer()
        gameTwoArray = Arrays.gameTwoArray.shuffled()
        tapCount = 0
        stepNumber = 0
        yourAnswer = [0,0,0,0]
    }
    
    func tapOnCard(index: Int) {
        if tapCount == 0 {
            withAnimation() {
                gameTwoArray[index].turn = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    tapCount += 1
                }
            }
        }
        if tapCount == 1 {
            withAnimation() {
                gameTwoArray[index].turn = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    tapCount = 0
                    
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation() {
                gameTwoArray[firstIndex].turn = false
                gameTwoArray[secondIndex].turn = false
                yourAnswer[stepNumber] = .random(in: 1...2)
                stepNumber += 1
            }
        }
    }
    
    func timeString(time: Int) -> String {
           let minutes = time / 60
           let seconds = time % 60
           return String(format: "%01d:%02d", minutes, seconds)
       }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
           elapsedTime -= 1
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
}

#Preview {
    MiniTwo()
}
