//
//  RegistrationView.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 16.04.2024.
//

import SwiftUI

struct RegistrationView: View {
    
    private var bounts = UIScreen.main.bounds
    @EnvironmentObject var rootViewModel: RootContentView.RootContentViewModel
    @StateObject private var viewModel = RegistrationViewModel()
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            HStack(spacing: 10) {
                Asset.logoFire.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: bounts.width * 0.125)
                
                Text("Maximidriveup")
                    .foregroundColor(.black)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 32))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            
            VStack {
                HStack {
                    Spacer()
                    Text("Регистрация")
                        .foregroundColor(.white)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 20))
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                        .padding(.top, 15)
                    
                    Spacer()
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Имя")
                        TextField(text: $viewModel.name) {
                            Text("Имя")
                        }
                    }
                    .padding()
                    
                    Spacer(minLength: .zero)
                }
                .background {
                    Color.white
                }
                .cornerRadius(8)
                .padding(15)
            }
            .background {
                Color.black
            }
            .cornerRadius(20)
            
            Spacer(minLength: .zero)
            
            NextButtonView(title: "Регистрация") {
                if viewModel.isValidName {
                    viewModel.saveName()
                    rootViewModel.setFlow(.main)
                }
            }
        }
        .padding()
        .navigationBarBackButtonHidden()
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
