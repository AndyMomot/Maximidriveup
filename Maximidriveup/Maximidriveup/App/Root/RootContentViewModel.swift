import Foundation

extension RootContentView {
    final class RootContentViewModel: ObservableObject {
        @Published var flow: DefaultsService.Flow = .onboarding
        @Published var isLoading = true
        
        func getFlow() {
            flow = DefaultsService.flow
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.isLoading = false
            }
        }
        
        func setFlow(_ flow: DefaultsService.Flow) {
            DefaultsService.setFlow(flow)
            getFlow()
        }
    }
}

