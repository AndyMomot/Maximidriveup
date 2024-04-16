//
//  NextButtonView.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 16.04.2024.
//

import SwiftUI

struct NextButtonView: View {
    var title = "Продолжить"
    var onTap: () -> Void
    
    var body: some View {
        
        Button {
            onTap()
        } label: {
            HStack(alignment: .center) {
                Spacer(minLength: .zero)
                
                Text(title)
                    .foregroundColor(.black)
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 15))
                    .padding(.vertical)
                
                Spacer(minLength: .zero)
            }
            .background {
                Colors.yellow.swiftUIColor
            }
            .cornerRadius(10)
        }
    }
}

struct NextButtonView_Previews: PreviewProvider {
    static var previews: some View {
        NextButtonView() {}
            .padding()
    }
}
