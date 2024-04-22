//
//  HistoryItemCell.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 22.04.2024.
//

import SwiftUI

struct HistoryItemCell: View {
    var item: HomeView.FinalNodeItem
    
    var body: some View {
        ZStack {
            Color.black
                .cornerRadius(10)
            
            VStack(alignment: .leading,spacing: 10) {
                HStack {
                    Text(item.title)
                        .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 15))
                    Spacer(minLength: .zero)
                }
                
                HStack(spacing: 10) {
                    HStack(spacing: 5) {
                        Text(item.costsText)
                            .foregroundColor(.white)
                            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 12))
                            .minimumScaleFactor(0.8)
                        
                        Group {
                            Text("\(item.costsValue)")
                            if item.costsText != "%" {
                                Text(DefaultsService.currency.icon)
                            }
                        }
                        .foregroundColor(.white)
                        .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 16))
                    }
                    
                    HStack(spacing: 5) {
                        Text(item.incomeText)
                            .foregroundColor(.white)
                            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 12))
                            .minimumScaleFactor(0.8)
                        
                        Group {
                            Text("\(item.incomeValue)")
                            Text(DefaultsService.currency.icon)
                        }
                        .foregroundColor(.white)
                        .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 16))
                    }
                    
                    Spacer(minLength: .zero)
                }
            }
            .padding()
        }
    }
}

struct HistoryItemCell_Previews: PreviewProvider {
    static var previews: some View {
        HistoryItemCell(item: .init(
            title: "Моя Прибыль",
            costsText: "%",
            costsValue: 15,
            incomeText: "Прибыль",
            incomeValue: 525,
            order: 0))
        .frame(height: 72)
    }
}
