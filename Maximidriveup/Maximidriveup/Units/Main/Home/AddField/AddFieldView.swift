//
//  AddFieldView.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 18.04.2024.
//

import SwiftUI

struct AddFieldView: View {
    @Binding var isAppeared: Bool
    @State private var isIncome = true
    @State private var text = ""
    
    var onCreate: (HomeView.IncomeCostModel) -> Void
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .onTapGesture {
                    toggleAppearance()
                }
            
            HStack {
                VStack(spacing: 20) {
                    VStack(spacing: .zero) {
                        HStack {
                            Spacer()
                            
                            Button {
                                toggleAppearance()
                            } label: {
                                Asset.crossBlack.swiftUIImage
                            }
                        }
                        
                        HStack {
                            Text("Добавление поля")
                                .foregroundColor(.black)
                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 20))
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                    }
                    
                    HStack(spacing: 20) {
                        NextButtonView(title: "Заработок") {
                            isIncome = true
                        }
                        .opacity(isIncome ? 1 : 0.5)
                        
                        NextButtonView(title: "Трата") {
                            isIncome = false
                        }
                        .opacity(isIncome ? 0.5 : 1)
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 2)
                                    .background(Color.clear)
                                    .cornerRadius(10)
                                    .frame(height: 44)
                        
                        TextField(text: $text) {
                            Text("Название")
                                .foregroundColor(.gray)
                                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                        }
                        .foregroundColor(.black)
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                        .padding(.horizontal)
                    }
                    
                    NextButtonView(title: "Добавить") {
                        validate()
                    }
                }
                .padding()
            }
            .frame(width: bounds.width - 40)
            .background(Color.white)
            .cornerRadius(10)
        }
    }
}
private extension AddFieldView {
    func toggleAppearance() {
        withAnimation {
            isAppeared.toggle()
        }
    }
    
    func createItem() -> HomeView.IncomeCostModel {
        var type: HomeView.IncomeCostModel.ItemType {
            isIncome ? .income : .cost
        }
        
        return .init(type: type, title: text)
    }
    
    func validate() {
        if !text.isEmpty {
            let item = createItem()
            onCreate(item)
            toggleAppearance()
        }
    }
}

struct AddFieldView_Previews: PreviewProvider {
    static var previews: some View {
        AddFieldView(isAppeared: .constant(false)) { _ in
            
        }
    }
}
