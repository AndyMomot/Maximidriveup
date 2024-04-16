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
            if viewModel.isOnboarded {
                MainTabBarView()
            } else {
                OnboardingViewTabView()
                    .environmentObject(viewModel)
            }
        }
        .onAppear {
            viewModel.checkOnbordingStatus()
        }
    }
}

struct RootContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootContentView()
    }
}
