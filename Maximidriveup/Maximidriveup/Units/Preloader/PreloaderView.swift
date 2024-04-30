import SwiftUI


struct PreloaderView: View {
    @State private var showContent = false
    
    var body: some View {
        ZStack {
            Color("darkGray")
                .ignoresSafeArea()
            VStack(spacing: 40) {
                Asset.logoFire.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 100)
                Text("Maximidriveup")
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 37))
                    .foregroundStyle(.white)
            }
        }
    }
}

struct PreloaderView_Previews: PreviewProvider {
    static var previews: some View {
        PreloaderView()
    }
}
