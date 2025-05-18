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
                ZStack {
                    Image("gameFrameRectangle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth*0.36)
                    Image("labyrinth")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth*0.25)
                    VStack {
                        ForEach(0..<labyrinthArray.count, id:\.self) { row in
                            HStack {
                                ForEach(0..<labyrinthArray[row].count, id:\.self) { col in
                                    Image("menIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: screenWidth*0.03)
                                }
                            }
                        }
                    }
                }
                Spacer()
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
