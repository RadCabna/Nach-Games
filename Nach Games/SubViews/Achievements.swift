//
//  Achievements.swift
//  Nach Games
//
//  Created by Алкександр Степанов on 18.05.2025.
//

import SwiftUI

struct Achievements: View {
    @AppStorage("coinCount") var coinCount = 0
    @EnvironmentObject var coordinator: Coordinator
    @Binding var showAchievements: Bool
    @State private var achievementsArray = Arrays.achievementsArray
    var body: some View {
        ZStack {
            Background(backgroundNumber: 1)
            VStack {
                ZStack {
                    Text("ACHIEVEMENTS")
                        .font(Font.custom("SigmarOne-Regular", size: screenWidth*0.04))
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 2)
                    HStack {
                        Image("backButton")
                            .resizable()
                            .scaledToFit()
                            .frame(height: screenWidth*0.06)
                            .onTapGesture {
                                showAchievements.toggle()
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
                    ForEach(0..<achievementsArray.count, id: \.self) { item in
                        Image("settingsFrame")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.15)
                            .overlay(
                                VStack {
                                    Image(achievementsArray[item].image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: screenWidth*0.08)
                                    Text(achievementsArray[item].name)
                                        .font(Font.custom("SigmarOne-Regular", size: screenWidth*0.011))
                                        .foregroundColor(.white)
                                }
                                    .opacity(0.2)
                            )
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    Achievements(showAchievements: .constant(true))
}
