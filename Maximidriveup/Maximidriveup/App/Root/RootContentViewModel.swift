//
//  RootContentViewModel.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 16.04.2024.
//

import Foundation

extension RootContentView {
    final class RootContentViewModel: ObservableObject {
        @Published var flow: DefaultsService.Flow = .onboarding
        
        func getFlow() {
            flow = DefaultsService.flow
        }
        
        func setFlow(_ flow: DefaultsService.Flow) {
            DefaultsService.setFlow(flow)
            getFlow()
        }
    }
}
