//
//  OnboardingView.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 16.04.2024.
//

import SwiftUI

struct OnboardingView: View {
    
    @StateObject private var viewModel = OnboardingViewModel()
    private var viewState: ViewState
    
    init(viewState: ViewState) {
        self.viewState = viewState
    }
    
    private var bounts = UIScreen.main.bounds
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(viewState.backgroundColorName)
                    .ignoresSafeArea(edges: .bottom)
                
                VStack(alignment: .center, spacing: 48) {
                    Image(viewState.imageName)
                        .offset(x: viewState.imageXOffset)
                        .padding(.top)
                    
                    ScrollView {
                        VStack(alignment: .center, spacing: 5) {
                            Text(viewState.title)
                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 17))
                            
                            Text(viewState.subtitle)
                                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 17))
                        }
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    
                    NextButtonView() {
                        viewModel.showPrivacy.toggle()
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    .padding(.bottom)
                    .padding(.bottom)
                }
            }
            .navigationDestination(
                isPresented: $viewModel.showPrivacy) {
                    PrivacyPolicyView()
                }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(viewState: .first)
    }
}