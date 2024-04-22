//
//  HistorySectionCell.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 22.04.2024.
//

import SwiftUI

struct HistorySectionCell: View {
    var section: HomeView.FinalNodeSection
    var onDelete: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(section.date.toString(format: .ddMMyy))
                    .foregroundColor(.black)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 17))
                
                Spacer(minLength: 10)
                
                Button {
                    onDelete()
                } label: {
                    Asset.tresh.swiftUIImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }

            }
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 10) {
                    ForEach(section.nodes.sorted(by: {$0.order < $1.order})) { item in
                        HistoryItemCell(item: item)
                    }
                }
            }
        }
    }
}

struct HistorySectionCell_Previews: PreviewProvider {
    static var previews: some View {
        HistorySectionCell(section: .init(nodes: [
            .init(
                title: "Учасник",
                costsText: "Сумма трат",
                costsValue: 1500,
                incomeText: "Сумма заработка",
                incomeValue: 1000,
                order: 0),
            .init(
                title: "Организатор",
                costsText: "Сумма трат",
                costsValue: 1500,
                incomeText: "Сумма заработка",
                incomeValue: 1000,
                order: 1),
            .init(
                title: "Итог",
                costsText: "Итог трат",
                costsValue: 1500,
                incomeText: "Итог заработка",
                incomeValue: 1000,
                order: 2),
            .init(
                title: "Моя Прибыль",
                costsText: "%",
                costsValue: 15,
                incomeText: "Прибыль",
                incomeValue: 525,
                order: 3),
        ])) {}
    }
}
