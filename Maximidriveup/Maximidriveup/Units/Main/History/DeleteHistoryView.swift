//
//  DeleteHistoryView.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 22.04.2024.
//

import SwiftUI

struct DeleteHistoryView: View {
    @Binding var isAppeared: Bool
    var onDelete: () -> Void
    
    var body: some View {
        HStack {
            VStack(spacing: 20) {
                VStack(spacing: .zero) {
                    HStack {
                        Spacer()
                        
                        Button {
                            isAppeared.toggle()
                        } label: {
                            Asset.crossBlack.swiftUIImage
                        }
                    }
                    
                    VStack(spacing: 20) {
                        HStack {
                            Text("Удалить ?")
                                .foregroundColor(.black)
                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 20))
                                .multilineTextAlignment(.leading)
                            Spacer(minLength: .zero)
                        }
                        HStack {
                            Text("Вы уверены что хотите удалить этот элемент из истории ?")
                                .foregroundColor(.black)
                                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 15))
                                .multilineTextAlignment(.leading)
                            
                            Spacer(minLength: .zero)
                        }
                    }
                }
                
                HStack(spacing: 20) {
                    NextButtonView(title: "Удалить") {
                        onDelete()
                        isAppeared.toggle()
                    }
                    
                    NextButtonView(title: "Сохранить") {
                        isAppeared.toggle()
                    }
                }
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(10)
    }
}

struct DeleteHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteHistoryView(isAppeared: .constant(true)) {}
    }
}
