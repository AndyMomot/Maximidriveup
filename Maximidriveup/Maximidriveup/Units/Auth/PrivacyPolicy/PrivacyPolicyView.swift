//
//  PrivacyPolicyView.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 16.04.2024.
//

import SwiftUI

struct PrivacyPolicyView: View {
    @EnvironmentObject var rootViewModel: RootContentView.RootContentViewModel
    @StateObject var viewModel = PrivacyPolicyViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .ignoresSafeArea(edges: .bottom)
                
                VStack(alignment: .center, spacing: 26) {
                    Asset.ppLogo.swiftUIImage
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Наша политика конфиденциальности обеспечивает защиту вашей личной информации.")
                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 17))
                            
                            Text("Мы тщательно следим за тем, чтобы ваши данные были защищены от несанкционированного доступа. Вы имеете право контролировать свою личную информацию и выбирать, как она используется. Мы гарантируем, что ваши данные будут использованы исключительно в рамках законных целей.")
                                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 17))
                        }
                        .foregroundColor(.black)
                    }
                    
                    Spacer(minLength: .zero)
                    
                    VStack(alignment: .center, spacing: 22) {
                        NextButtonView {
                            if viewModel.isAgreed {
                                viewModel.showRegistration.toggle()
                                
                            }
                        }
                        .opacity(viewModel.isAgreed ? 1 : 0.5)
                        
                        CheckBoxView(text: "Я согласен с политикой конфиденциальности",
                                     url: viewModel.privacyURL) { selection in
                            viewModel.isAgreed = selection
                        }
                    }
                }
                .padding()
                .navigationBarBackButtonHidden()
                .navigationDestination(isPresented: $viewModel.showRegistration) {
                    RegistrationView()
                }
            }
        }
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PrivacyPolicyView()
        }
    }
}
