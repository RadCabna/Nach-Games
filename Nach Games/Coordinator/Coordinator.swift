//
//  Coordinator.swift
//  Nach Games
//
//  Created by Алкександр Степанов on 14.05.2025.
//

import Foundation
import SwiftUI

enum CoordinatorView: Equatable {
    case loading
    case mainMenu
    case training
    case game
    case selectMiniGame
   case miniOne
    case miniTwo
    case miniThree
    case miniFour
    case gameMode
    case selectHorse
}

final class Coordinator: ObservableObject {
    @Published var path: [CoordinatorView] = []

    func resolve(pathItem: CoordinatorView) -> AnyView {
        var view = AnyView(Loading())
        switch pathItem {
        case .loading:
            view = AnyView(Loading())
        case .mainMenu:
            view = AnyView(Menu())
        case .game:
            view = AnyView(Game())
        case .training:
            view = AnyView(Training())
        case .miniOne:
            view = AnyView(MiniOne())
        case .miniTwo:
            view = AnyView(MiniTwo())
        case .miniThree:
            view = AnyView(MiniThree())
        case .miniFour:
            view = AnyView(MiniFour())
        case .gameMode:
            view = AnyView(GameMode())
        case .selectMiniGame:
            view = AnyView(SelectMiniGame())
        case .selectHorse:
            view = AnyView(ChoseYourHorse())
        }
        return view
    }
    
    func navigate(to pathItem: CoordinatorView) {
        path.append(pathItem)
    }
    
    func navigateBack() {
        _ = path.popLast()
    }
}

struct ContentView: View {
    @StateObject private var coordinator = Coordinator()
    
    var body: some View {
        ZStack {
            coordinator.resolve(pathItem: coordinator.path.last ?? .loading)
        }
        .environmentObject(coordinator)
    }
}

#Preview {
    ContentView()
}




