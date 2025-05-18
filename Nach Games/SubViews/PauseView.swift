//
//  PauseView.swift
//  Nach Games
//
//  Created by Алкександр Степанов on 18.05.2025.
//

import SwiftUI

struct PauseView: View {
    @EnvironmentObject var coordinator: Coordinator
    @Binding var pauseTapped: Bool
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            Image("settingsFrame")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.29)
                .overlay(
                    VStack {
                        Text("PAUSE")
                            .font(Font.custom("SigmarOne-Regular", size: screenWidth*0.04))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2)
                        MenuButton(size: 0.13, text: "MENU")
                            .onTapGesture {
                                coordinator.navigate(to: .mainMenu)
                            }
                        MenuButton(size: 0.13, text: "CONTINUE")
                            .onTapGesture {
                                pauseTapped.toggle()
                            }
                    }
                )
        }
    }
}

#Preview {
    PauseView(pauseTapped: .constant(true))
}
