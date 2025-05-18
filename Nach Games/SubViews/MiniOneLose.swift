//
//  MiniOneLose.swift
//  Nach Games
//
//  Created by Алкександр Степанов on 18.05.2025.
//

import SwiftUI

struct MiniOneLose: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount = 0
    @Binding var miniOneLose: Bool
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
                            Text("YOU LOSE")
                                .font(Font.custom("SigmarOne-Regular", size: screenWidth*0.04))
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 2)
                                .padding(.bottom)
                            MenuButton(size: 0.13, text: "RETRY")
                                .onTapGesture {
                                    miniOneLose.toggle()
                                }
                            MenuButton(size: 0.13, text: "MENU")
                                .onTapGesture {
                                    coordinator.navigate(to: .mainMenu)
                                }
                               
                        }
                    }
                )
            
        }
    }
}

#Preview {
    MiniOneLose(miniOneLose: .constant(true))
}
