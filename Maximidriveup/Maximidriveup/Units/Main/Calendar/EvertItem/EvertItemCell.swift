//
//  EvertItemCell.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 24.04.2024.
//

import SwiftUI

struct EvertItemCell: View {
    var item: CustomCalendarView.EventModel
    var onDelete: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                HStack(spacing: 10) {
                    Circle()
                        .stroke(Color.black, lineWidth: 3)
                    .frame(width: 10)
                    
                    HStack(spacing: 0) {
                        Text(item.start.toString(format: .hhmm))
                        Text(" - ")
                        Text(item.end.toString(format: .hhmm))
                        Text("   ")
                        Text(item.date.toString(format: .ddMMyy))
                    }
                    .foregroundColor(.black)
                    .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 12))
                        
                }
                
                Spacer()
                
                Button {
                    onDelete()
                } label: {
                    Asset.tresh.swiftUIImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                }

            }
            
            Text(item.name)
                .foregroundColor(.black)
                .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 16))
            
            Text(item.description)
                .foregroundColor(.black)
                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 12))
        }
        .padding()
        .background {
            Colors.yellow.swiftUIColor
                .cornerRadius(10)
        }
        
    }
}

struct EvertItemCell_Previews: PreviewProvider {
    static var previews: some View {
        EvertItemCell(item: .init(
            name: "Встреча с организатором",
            description: "Кафе на улице Шевченка",
            date: .init(),
            start: .init(),
            end: .init(),
            autoDelete: true)) {}
    }
}
