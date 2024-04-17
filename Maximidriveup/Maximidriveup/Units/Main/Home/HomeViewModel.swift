//
//  HomeViewModel.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 17.04.2024.
//

import Foundation

extension HomeView {
    final class HomeViewModel: ObservableObject {
        let segmentItems = ["Учасник", "Организатор", "Финал"]
        @Published var selectedSegment = 0
    }
}
