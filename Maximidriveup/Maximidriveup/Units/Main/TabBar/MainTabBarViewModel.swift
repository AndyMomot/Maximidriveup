//
//  MainTabBarViewModel.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 17.04.2024.
//

import Foundation

extension MainTabBarView {
    final class TabBarViewModel: ObservableObject {
        @Published var selection = TabBarSelectionView.home.rawValue
    }
}

extension MainTabBarView {
    enum TabBarSelectionView: Int {
        case home = 0
        case calendar = 1
        case help = 2
        case settings = 3
    }
    
    struct Item {
        var backgroundImage: String
    }
}
