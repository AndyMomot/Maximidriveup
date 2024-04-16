//
//  RootContentViewModel.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 16.04.2024.
//

import Foundation

extension RootContentView {
    final class RootContentViewModel: ObservableObject {
        @Published var isOnboarded = false
        
        func checkOnbordingStatus() {
            isOnboarded = DefaultsService.isOnboarded
        }
    }
}
