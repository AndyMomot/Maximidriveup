//
//  OnboardingViewTabView.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 16.04.2024.
//

import SwiftUI

struct OnboardingViewTabView: View {
    var body: some View {
        TabView {
            OnboardingView(viewState: .first)
            OnboardingView(viewState: .second)
        }
        .ignoresSafeArea(edges: .bottom)
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct OnboardingViewTabView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingViewTabView()
    }
}
