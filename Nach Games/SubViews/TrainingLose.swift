//
//  TrainingLose.swift
//  Nach Games
//
//  Created by Алкександр Степанов on 18.05.2025.
//

import SwiftUI

struct TrainingLose: View {
    @EnvironmentObject var coordinator: Coordinator
    @Binding var trainingLose: Bool
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            Image("settingsFrame")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.29)
                .overlay(
                    VStack() {
                        Text("YOU LOSE")
                            .font(Font.custom("SigmarOne-Regular", size: screenWidth*0.04))
                            .foregroundColor(.red)
                            .shadow(color: .black, radius: 2)
                        MenuButton(size: 0.13, text: "RETRY")
                            .onTapGesture {
                                trainingLose.toggle()
                            }
                        MenuButton(size: 0.13, text: "MENU")
                            .onTapGesture {
                                coordinator.navigate(to: .mainMenu)
                            }
                           
                    }
                )
        }
    }
}

#Preview {
    TrainingLose(trainingLose: .constant(true))
}
