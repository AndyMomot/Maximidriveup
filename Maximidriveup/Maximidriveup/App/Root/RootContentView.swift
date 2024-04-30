import SwiftUI

struct RootContentView: View {
    @StateObject private var viewModel = RootContentViewModel()
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                PreloaderView()
            } else {
                switch viewModel.flow {
                case .onboarding:
                    OnboardingViewTabView()
                        .environmentObject(viewModel)
                case .privacyPolicy:
                    PrivacyPolicyView()
                        .environmentObject(viewModel)
                case .main:
                    MainTabBarView()
                        .environmentObject(viewModel)
                }
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
