//
//  CheckBoxView.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 16.04.2024.
//

import SwiftUI

struct CheckBoxView: View {
    var text: String
    var onTap: (Bool) -> Void
    
    @State private var selection = false
    
    init(text: String, onTap: @escaping (Bool) -> Void) {
        self.text = text
        self.onTap = onTap
    }
    
    var body: some View {
        HStack(spacing: 8) {
            ZStack {
                Rectangle()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: 21)
                    .cornerRadius(4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(.black, lineWidth: 1)
                    )
                    .onTapGesture {
                        selection.toggle()
                        onTap(selection)
                    }
                
                if selection {
                    Image(systemName: "checkmark", variableValue: 1)
                        .symbolRenderingMode(.monochrome)
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: .bold))
                }
            }
            
            Text(text)
                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 14))
                .foregroundColor(Colors.darkGray.swiftUIColor)
            
            Spacer(minLength: .zero)
        }
    }
}

struct CheckBoxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxView(text: "Я согласен с политикой конфиденциальности ") { _ in }
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
