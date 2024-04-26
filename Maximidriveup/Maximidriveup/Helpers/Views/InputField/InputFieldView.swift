//
//  InputFieldView.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 26.04.2024.
//

import SwiftUI

struct InputFieldView: View {
    var title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .foregroundColor(.black)
                    .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 14))
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 2)
                            .background(Color.white)
                            .cornerRadius(10)
                            .frame(height: 44)
                
                TextField(text: $text) {}
                .foregroundColor(.black)
                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 14))
                .padding(.horizontal)
            }
        }
    }
}

struct InputFieldView_Previews: PreviewProvider {
    static var previews: some View {
        InputFieldView(title: "Имя", text: .constant("Имя"))
    }
}
