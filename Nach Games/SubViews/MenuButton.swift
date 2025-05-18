//
//  MenuButton.swift
//  Nach Games
//
//  Created by Алкександр Степанов on 15.05.2025.
//

import SwiftUI

struct MenuButton: View {
    var size:CGFloat = 0.15
    var text = "UPGRADE"
    var body: some View {
       Image("menuButton")
            .resizable()
            .scaledToFit()
            .frame(height: screenWidth*size*0.5)
            .overlay(
                Text(text)
                    .font(Font.custom("SigmarOne-Regular", size: size*screenWidth*0.16))
                    .foregroundColor(Color("textColor"))
                    .shadow(color: Color("shadowColor"), radius: 2)
                    .shadow(color: Color("shadowColor"), radius: 2)
                    .padding(.bottom, screenHeight*size*0.1)
            )
    }
}

#Preview {
    MenuButton()
}
