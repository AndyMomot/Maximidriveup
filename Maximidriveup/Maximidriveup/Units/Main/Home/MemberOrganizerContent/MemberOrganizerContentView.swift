//
//  MemberContentView.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 18.04.2024.
//

import SwiftUI

struct MemberOrganizerContentView: View {
    var items: [HomeView.IncomeCostModel]
    var onDelete: (Int) -> Void
    var onSumChanged: (_ index: Int, _ sum: Int) -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(10)
            .foregroundColor(.black)
            
            ScrollView(showsIndicators: false) {
                
                if items.isEmpty {
                    Text("Пусто")
                        .foregroundColor(.white)
                        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 14))
                        .padding()
                } else {
                    ForEach(Array(items.enumerated()), id: \.element) { index, item in
                        
                        FieldCell(item: item) {
                            onDelete(index)
                        } onSumChanged: { sum in
                            onSumChanged(index, sum)
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

struct MemberContentView_Previews: PreviewProvider {
    static var previews: some View {
        MemberOrganizerContentView(
            items: [.init(type: .cost, title: "test")],
            onDelete: { _ in },
            onSumChanged: {_, _ in}
        )
        .padding()
    }
}
