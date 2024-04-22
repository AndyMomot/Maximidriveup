//
//  OnboardingViewTabView.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 16.04.2024.
//

import SwiftUI

struct OnboardingViewTabView: View {
   private let numberOfTabs = 2
    
    var body: some View {
        TabView {
            OnboardingView(viewState: .first,
                           numberOfTabs: numberOfTabs,
                           position: 0)
            OnboardingView(viewState: .second,
                           numberOfTabs: numberOfTabs,
                           position: 1)
        }
        .ignoresSafeArea(edges: .bottom)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .indexViewStyle(.page(backgroundDisplayMode: .never))
    }
}

struct OnboardingViewTabView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingViewTabView()
    }
}
