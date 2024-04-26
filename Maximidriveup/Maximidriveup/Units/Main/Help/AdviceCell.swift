//
//  AdviceCell.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 26.04.2024.
//

import SwiftUI

struct AdviceCell: View {
    var advice: HelpView.AdviceModel
    
    @State private var showDescription = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Button {
                    withAnimation {
                        showDescription.toggle()
                    }
                } label: {
                    var imageName: String {
                        if showDescription {
                            return "plus"
                        } else {
                            return "minus"
                        }
                    }
                    
                    Image(systemName: imageName)
                        .foregroundColor(.black)
                        .font(.largeTitle)
                }

                Spacer(minLength: 15)
                
                Text(advice.title)
                    .foregroundColor(.black)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(fixedSize: 17))
            }
            
            if showDescription {
                Text(advice.description)
                    .foregroundColor(.black)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(fixedSize: 17))
            }
        }
        .multilineTextAlignment(.leading)
        .padding(12)
        .background(Colors.yellow.swiftUIColor)
        .cornerRadius(7)
    }
}

struct AdviceCell_Previews: PreviewProvider {
    static var previews: some View {
        AdviceCell(advice: .init(
            title: "Как зарегистрироваться на участие в конкретном соревновании или событии?",
            description: "Как зарегистрироваться на участие в конкретном соревновании или событии?"))
    }
}
