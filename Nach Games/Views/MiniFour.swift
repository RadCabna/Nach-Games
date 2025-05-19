//
//  MiniFour.swift
//  Nach Games
//
//  Created by Алкександр Степанов on 18.05.2025.
//

import SwiftUI

struct MiniFour: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount = 0
    @State private var timer: Timer? = nil
    @State private var elapsedTime = 60
    @State private var labyrinthArray = Arrays.GameFourArray
    @State private var youWin = false
    @State private var youLose = false
    var body: some View {
        ZStack {
            Background(backgroundNumber: 1)
            VStack {
                ZStack {
                    Text("LABYRINTH")
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
                HStack {
                    VStack {
                        Image("arrowUp")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.06)
                            .onTapGesture {
                                stepUp()
                            }
                        HStack(spacing: screenWidth*0.08) {
                            Image("arrowLeft")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.06)
                                .onTapGesture {
                                    stepLeft()
                                }
                            Image("arrowLeft")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.06)
                                .scaleEffect(x: -1)
                                .onTapGesture {
                                    stepRight()
                                }
                        }
                        Image("arrowUp")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.06)
                            .scaleEffect(y: -1)
                            .onTapGesture {
                                stepDown()
                            }
                    }
                    Spacer()
                        .frame(width: screenWidth*0.06)
                    ZStack {
                        Image("gameFrameRectangle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.36)
                        Image("labyrinth")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.25)
                        VStack(spacing: screenWidth*0.008) {
                            ForEach(0..<labyrinthArray.count, id:\.self) { row in
                                HStack(spacing: screenWidth*0.008) {
                                    ForEach(0..<labyrinthArray[row].count, id:\.self) { col in
                                        ZStack {
                                            Image("menIcon")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: screenWidth*0.032)
                                                .opacity(labyrinthArray[row][col].men ? 1 : 0)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    Spacer()
                }
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
        
        .onChange(of: elapsedTime) { _ in
        if elapsedTime <= 0 {
            stopTimer()
                youLose = true
            }
        }
        
        .onChange(of: labyrinthArray) { _ in
            if labyrinthArray[5][2].men {
                stopTimer()
                youWin = true
            }
        }
        .onChange(of: youWin) { _ in
            if youWin {
                restartGame()
            }
        }
    }
    
    func restartGame() {
        elapsedTime = 60
        for i in 0..<labyrinthArray.count {
            for j in 0..<labyrinthArray[i].count {
                labyrinthArray[i][j].men = false
            }
        }
        labyrinthArray[0][2].men = true
    }
    
    func stepLeft() {
        var row = 0
        var col = 0
        for i in 0..<labyrinthArray.count {
            for j in 0..<labyrinthArray[i].count {
                if labyrinthArray[i][j].men {
                    row = i
                    col = j
                }
            }
        }
        if labyrinthArray[row][col].left {
            labyrinthArray[row][col].men = false
            withAnimation() {
                labyrinthArray[row][col-1].men = true
            }
        }
    }
    
    func stepRight() {
        var row = 0
        var col = 0
        for i in 0..<labyrinthArray.count {
            for j in 0..<labyrinthArray[i].count {
                if labyrinthArray[i][j].men {
                    row = i
                    col = j
                }
            }
        }
        if labyrinthArray[row][col].right {
            labyrinthArray[row][col].men = false
            withAnimation() {
                labyrinthArray[row][col+1].men = true
            }
        }
    }
    
    func stepDown() {
        var row = 0
        var col = 0
        for i in 0..<labyrinthArray.count {
            for j in 0..<labyrinthArray[i].count {
                if labyrinthArray[i][j].men {
                    row = i
                    col = j
                }
            }
        }
        if labyrinthArray[row][col].down {
            labyrinthArray[row][col].men = false
            withAnimation() {
                labyrinthArray[row+1][col].men = true
            }
        }
    }
    
    func stepUp() {
        var row = 0
        var col = 0
        for i in 0..<labyrinthArray.count {
            for j in 0..<labyrinthArray[i].count {
                if labyrinthArray[i][j].men {
                    row = i
                    col = j
                }
            }
        }
        if labyrinthArray[row][col].up {
            labyrinthArray[row][col].men = false
            withAnimation() {
                labyrinthArray[row-1][col].men = true
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
    MiniFour()
}
