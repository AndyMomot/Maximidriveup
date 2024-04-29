//
//  SettingsView.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 17.04.2024.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            GradientBackground()
                .ignoresSafeArea(edges: .bottom)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    ZStack {
                        if let image = UIImage(data: viewModel.imageData) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .clipped()
                                .frame(maxWidth: bounds.width,
                                       maxHeight: 200)
                        } else {
                            Asset.placeholder.swiftUIImage
                                .resizable()
                                .scaledToFit()
                                .frame(width: bounds.width,
                                        height: 200)
                                .ignoresSafeArea(edges: .horizontal)
                                .border(Color.gray)
                        }
                        
                        VStack {
                            HStack {
                                Spacer()
                                Button {
                                    DispatchQueue.main.async {
                                        withAnimation {
                                            self.viewModel.showGallery.toggle()
                                        }
                                    }
                                } label: {
                                    Asset.camera.swiftUIImage
                                }
                                .padding()
                            }
                            
                            Spacer()
                        }
                    }
                    
                    VStack(spacing: 10) {
                        InputFieldView(title: "Имя",
                                       text: $viewModel.user.firstName)
                        InputFieldView(title: "Фамилия",
                                       text: $viewModel.user.lastName)
                        InputFieldView(title: "Год рождения",
                                       text: $viewModel.user.year)
                        InputFieldView(title: "Почта",
                                       text: $viewModel.user.email)
                        InputFieldView(title: "Страна",
                                       text: $viewModel.user.country)
                        CurrencyPicker { currency in
                            viewModel.currency = currency
                        }
                    }
                    .padding()
                    
                    NextButtonView(title: "Сохранить") {
                        viewModel.onSaveTapped()
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
            .frame(maxHeight: bounds.height * 0.75)
        }
        .sheet(isPresented: $viewModel.showGallery) {
            ImagePicker(selectedImageData: $viewModel.imageData)
        }
        .onAppear {
            withAnimation {
                viewModel.getImage()
                viewModel.getUser()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
