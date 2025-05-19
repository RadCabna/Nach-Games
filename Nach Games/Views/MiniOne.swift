//
//  MiniOne.swift
//  Nach Games
//
//  Created by Алкександр Степанов on 18.05.2025.
//

import SwiftUI

struct MiniOne: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount = 0
    @State private var correctNumber = [4, 5, 6]
    @State private var yourNumber = [0, 0, 0]
    @State private var numberId = 0
    @State private var youWin = false
    @State private var youLose = false
    var body: some View {
        ZStack {
            Background(backgroundNumber: 1)
            VStack {
                ZStack {
                    Text("GUESSTHE NUMBER")
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
                                ForEach (0..<correctNumber.count, id:\.self) { id in
                                    Image("emptyRectangle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: screenWidth*0.06)
                                        .overlay(
                                            ZStack {
                                                if yourNumber[id] != 0 {
                                                    Text("\(yourNumber[id])")
                                                        .font(Font.custom("SigmarOne-Regular", size: screenWidth*0.03))
                                                        .foregroundColor(yourNumber[id] == correctNumber[id] ? .white : .red)
                                                    
                                                }
                                            }
                                        )
                                }
                            }
                            HStack {
                                ForEach (0..<5, id:\.self) { id in
                                    Image("numberFrame")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: screenWidth*0.07)
                                        .overlay(
                                            Text("\(id + 1)")
                                                .font(Font.custom("SigmarOne-Regular", size: screenWidth*0.04))
                                                .foregroundColor(Color("textColor"))
                                                .shadow(color: Color("shadowColor"), radius: 2)
                                                .shadow(color: Color("shadowColor"), radius: 2)
                                                .padding(.bottom, screenWidth*0.005)
                                        )
                                        .onTapGesture {
                                            tapOnNumber(id: id)
                                        }
                                }
                            }
                            HStack {
                                ForEach (5..<10, id:\.self) { id in
                                    Image("numberFrame")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: screenWidth*0.07)
                                        .overlay(
                                            Text("\(id + 1)")
                                                .font(Font.custom("SigmarOne-Regular", size: screenWidth*0.04))
                                                .foregroundColor(Color("textColor"))
                                                .shadow(color: Color("shadowColor"), radius: 2)
                                                .shadow(color: Color("shadowColor"), radius: 2)
                                                .padding(.bottom, screenWidth*0.005)
                                        )
                                        .onTapGesture {
                                            tapOnNumber(id: id)
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
        
        .onChange(of: youLose) { _ in
            if !youLose {
                yourNumber = [0, 0, 0]
                numberId = 0
            }
        }
        
        .onChange(of: youWin) { _ in
            if !youWin {
                randomeNumver()
                yourNumber = [0, 0, 0]
                numberId = 0
            }
        }
        
        .onChange(of: numberId) { _ in
            if numberId == 3 {
                if checkCorrect() {
                    youWin = true
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        youLose = true
                    }
                }
            }
        }
    }
    
    func randomeNumver() {
        for i in 0..<correctNumber.count {
            correctNumber[i] = Int.random(in: 1...10)
        }
    }
    
    func checkCorrect() -> Bool{
        var gameDone = false
        for i in 0..<yourNumber.count {
            if yourNumber[i] == correctNumber[i] {
                gameDone = true
            } else {
                gameDone = false
            }
        }
        return gameDone
    }
    
    func tapOnNumber(id: Int) {
        if numberId < 3 {
            yourNumber[numberId] = id+1
            numberId += 1
        }
    }
    
}

#Preview {
    MiniOne()
}
