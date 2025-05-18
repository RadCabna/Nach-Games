//
//  ChangeHorseName.swift
//  Nach Games
//
//  Created by Алкександр Степанов on 15.05.2025.
//

import SwiftUI

struct ChangeHorseName: View {
    @Binding var changeNameTapped: Bool
    @Binding var horseNumber: Int
    @State private var horsesNameArray = UserDefaults.standard.array(forKey: "horsesNameArray") as? [String] ?? ["Bruno","Rune","Zephyr","Ash"]
    @State private var horseName = "HORSE"
    var body: some View {
        Image("settingsFrame")
            .resizable()
            .scaledToFit()
            .frame(width: screenWidth*0.28)
            .overlay(
                VStack {
                    Text("RENAME \nHORSE")
                        .font(Font.custom("SigmarOne-Regular", size: screenWidth*0.03))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    Image("horseNameFrame")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth*0.2)
                        .overlay(
                            TextField("Введите новое название", text: $horseName)
                        )
                    MenuButton(size: 0.13, text: "SAVE")
                        .padding(.top)
                }
            )
            .padding(.top)
    }
}

#Preview {
    ChangeHorseName(changeNameTapped: .constant(true), horseNumber: .constant(0))
}
