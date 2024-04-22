//
//  OnboardingView.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 16.04.2024.
//

import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject var rootViewModel: RootContentView.RootContentViewModel
    private var viewState: ViewState
    private var numberOfTabs = 0
    private var position = 0
    
    init(viewState: ViewState,
         numberOfTabs: Int = 0,
         position: Int = 0) {
        self.viewState = viewState
        self.numberOfTabs = numberOfTabs
        self.position = position
    }
    
    private var bounts = UIScreen.main.bounds
    
    var body: some View {
        let tabIndices = Array(0..<numberOfTabs)
        
        ZStack {
            Color(viewState.backgroundColorName)
                .ignoresSafeArea(edges: .bottom)
            
            VStack(alignment: .center, spacing: 48) {
                Image(viewState.imageName)
                    .offset(x: viewState.imageXOffset)
                    .padding(.top)
                
                VStack(spacing: 10) {
                    // Page indicator
                    HStack(alignment: .center, spacing: 5) {
                        ForEach(tabIndices, id: \.self) { index in
                            var color: Color {
                                if position == index {
                                    return Colors.yellow.swiftUIColor
                                } else {
                                    return Colors.yellow.swiftUIColor.opacity(0.4)
                                }
                            }
                            
                            Circle()
                                .frame(width: 12)
                                .foregroundColor(color)
                        }
                    }
                    
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
                }
                
                Spacer()
                
                NextButtonView() {
                    rootViewModel.setFlow(.privacyPolicy)
                }
                .padding(.horizontal)
                .padding(.bottom)
                .padding(.bottom)
                .padding(.bottom)
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(viewState: .first, numberOfTabs: 3, position: 0)
    }
}
