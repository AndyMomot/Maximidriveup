//
//  DayOfMonthCell.swift
//  TesejournerX
//
//  Created by Andrii Momot on 01.04.2024.
//

import SwiftUI

struct DayOfMonthCell: View {
    var model: CustomCalendarView.DayOfMonthModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            HStack {
                Spacer(minLength: .zero)
                
                ZStack {
                    Rectangle()
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(10)
                        .frame(maxWidth: 30, maxHeight: 30)
                        .foregroundColor(model.state == .today ? .black : .clear)
                    
                    Text(model.day)
                        .font(model.font)
                        .foregroundColor(model.foregroundColor)
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                }
                
                Spacer(minLength: .zero)
            }
            
            HStack(alignment: .center, spacing: 2) {
                if model.events > 0 {
                    let eventRange = Array(0..<model.events)
                    ForEach(eventRange.prefix(4), id: \.self) { _ in
                        Circle()
                            .stroke(.black, lineWidth: 1)
                            .scaledToFit()
                            .foregroundColor(.red)
                            .frame(maxWidth: 4, maxHeight: 4)
                    }
                } else {
                    Circle()
                        .stroke(.clear, lineWidth: 1)
                        .foregroundColor(.clear)
                        .frame(maxWidth: 4, maxHeight: 4)
                }
            }
        }
    }
}

struct DayOfMonthCell_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            DayOfMonthCell(model: .init(state: .today,
                                        day: "31",
                                        events: 1))
            .previewLayout(.fixed(width: 53, height: 83))
            
            Divider()
            
            DayOfMonthCell(model: .init(state: .weekDay,
                                        day: "31",
                                        events: 2))
            .previewLayout(.fixed(width: 53, height: 83))
            
            Divider()
            
            DayOfMonthCell(model: .init(state: .outOfMonth,
                                        day: "31",
                                        events: 3))
            .previewLayout(.fixed(width: 53, height: 83))
        }
            
    }
}
