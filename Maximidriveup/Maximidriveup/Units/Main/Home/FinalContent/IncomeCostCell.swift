//
//  IncomeCostCell.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 19.04.2024.
//

import SwiftUI

struct IncomeCostCell: View {
    var model: HomeView.FinalIncomeCostModel
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 0) {
            VStack {
                Text(model.title)
                    .foregroundColor(.white)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 15))
                Spacer()
            }
            .padding(.top)
            .padding(.leading, 10)
            
            Spacer(minLength: 4)
            
            VStack(spacing: 10) {
                createFieldView(
                    name: model.topFieldName,
                    value: model.topFieldValue,
                    showDollar: model.showTopFieldDollarMark,
                    canEditTopField: model.canEditTopField)
                
                createFieldView(
                    name: model.bottomFieldName,
                    value: model.bottomFieldValue,
                    showDollar: model.showBottomFieldDollarMark)
            }
            .padding(.top)
            .padding(.horizontal)
            .padding(.bottom)
            
        }
        .background(Color.black)
        .cornerRadius(10)
    }
}

private extension IncomeCostCell {
    func createFieldView(name: String,
                         value: Double,
                         showDollar: Bool = true,
                         canEditTopField: Bool = false) -> some View {
        HStack {
            Spacer(minLength: .zero)
            
            Text(name)
                .foregroundColor(.white)
                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 12))
            
            ZStack {
                Color.white
                    .frame(
                        width: 100,
                        height: 30)
                    .cornerRadius(8)
                
                if canEditTopField {
                    TextField(text: $text) {
                        Text("\(Int(value))")
                            .foregroundColor(.gray)
                            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 14))
                            .multilineTextAlignment(.center)
                    }
                    .keyboardType(.numberPad)
                    .frame(maxWidth: 80)
                    .multilineTextAlignment(.center)
                    
                } else {
                    Text("\(Int(value))")
                        .foregroundColor(.black)
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 14))
                }
            }
            
            if showDollar {
                Text(DefaultsService.currency.icon)
                    .foregroundColor(.white)
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 24))
            }
        }
    }
}

struct IncomeCostCell_Previews: PreviewProvider {
    static var previews: some View {
        IncomeCostCell(model: .init(
            title: "Учасник",
            topFieldName: "Сумма трат",
            bottomFieldName: "Сумма заработка",
            topFieldValue: 100,
            bottomFieldValue: 200,
            showTopFieldDollarMark: false,
            showBottomFieldDollarMark: true,
            canEditTopField: true
        ), text: .constant(""))
        .previewLayout(.fixed(width: 335, height: 90))
    }
}
