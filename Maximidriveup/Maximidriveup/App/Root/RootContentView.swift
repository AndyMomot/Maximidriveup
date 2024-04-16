//
//  RootContentView.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 16.04.2024.
//

import SwiftUI

struct RootContentView: View {
    @StateObject private var viewModel = RootContentViewModel()
    
    var body: some View {
        Group {
            switch viewModel.flow {
            case .onboarding:
                OnboardingViewTabView()
                    .environmentObject(viewModel)
            case .privacyPollycy:
                PrivacyPolicyView()
                    .environmentObject(viewModel)
            case .main:
                MainTabBarView()
                    .environmentObject(viewModel)
            }
        }
        .onAppear {
            viewModel.getFlow()
        }
    }
}

struct RootContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootContentView()
    }
}
