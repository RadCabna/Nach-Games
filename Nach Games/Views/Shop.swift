//
//  Shop.swift
//  Nach Games
//
//  Created by Алкександр Степанов on 18.05.2025.
//

import SwiftUI

struct Shop: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("bgNumber") var bgNumber = 6
    @AppStorage("coinCount") var coinCount = 0
    @State private var shopItemsArray = Arrays.shopItemsArray
    @State private var shopItemsData = UserDefaults.standard.array(forKey: "shopItemsData") as? [Int] ?? [0,0,0,0]
    @Binding var showShop: Bool
    var body: some View {
        ZStack {
            Background(backgroundNumber: 1)
            VStack {
                ZStack {
                    Text("SHOP")
                        .font(Font.custom("SigmarOne-Regular", size: screenWidth*0.04))
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 2)
                    HStack {
                        Image("backButton")
                            .resizable()
                            .scaledToFit()
                            .frame(height: screenWidth*0.06)
                            .onTapGesture {
                                showShop.toggle()
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
                            .onTapGesture {
                                coinCount += 1000
                            }
                    }
                }
                .padding()
                Spacer()
                HStack {
                    ForEach(0..<shopItemsArray.count, id: \.self) { item in
                        Image("settingsFrame")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.19)
                            .overlay(
                                VStack {
                                    Image(shopItemsArray[item].name)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: screenWidth*0.14)
                                    HStack {
                                        Image("coin")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: screenWidth*0.015)
                                        Text("\(shopItemsArray[item].cost)")
                                            .font(Font.custom("SigmarOne-Regular", size: screenWidth*0.02))
                                            .foregroundColor(.white)
                                    }
                                    if shopItemsData[item] == 0 {
                                        MenuButton(size: 0.08, text: "BUY")
                                            .onTapGesture {
                                                if coinCount >= shopItemsArray[item].cost {
                                                    buyItem(item: item)
                                                }
                                            }
                                    }
                                    if shopItemsData[item] == 1 {
                                        MenuButton(size: 0.08, text: "SELECT")
                                            .onTapGesture {
                                                selectItem(item: item)
                                            }
                                    }
                                    if shopItemsData[item] == 2 {
                                        MenuButton(size: 0.08, text: "SELECTED")
                                    }
                                }
                            )
                    }
                }
                Spacer()
            }
        }
    }
    
    func buyItem(item: Int) {
        coinCount -= shopItemsArray[item].cost
        shopItemsData[item] = 1
        UserDefaults.standard.setValue(shopItemsData, forKey: "shopItemsData")
    }
    
    func selectItem(item: Int) {
        for i in 0..<shopItemsData.count {
            if shopItemsData[i] == 2 {
                shopItemsData[i] = 1
            }
        }
        shopItemsData[item] = 2
        bgNumber = item + 2
        UserDefaults.standard.setValue(shopItemsData, forKey: "shopItemsData")
    }
    
}

#Preview {
    Shop(showShop: .constant(true))
}
