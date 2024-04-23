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
        VStack(alignment: .center) {
            HStack {
                Spacer()
                
                
                ZStack {
                    if model.state == .today {
                        Rectangle()
                            .cornerRadius(10)
                            .frame(width: 30, height: 30)
                            .padding(.top)
                    }
                    Text(model.day)
                        .font(model.font)
                        .foregroundColor(model.foregroundColor)
                        .padding(.top)
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                }
                
                Spacer()
            }
            
            HStack(alignment: .center, spacing: 2) {
                if model.events > 0 {
                    let eventRange = Array(0..<model.events)
                    ForEach(eventRange, id: \.self) { _ in
                        Circle()
                            .stroke(.black, lineWidth: 1)
                            .foregroundColor(.red)
                            .frame(width: 4, height: 4)
                    }
                }
            }
            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 12))
            .lineLimit(1)
            .minimumScaleFactor(0.8)
            .padding(.horizontal, 3)
            .padding(.bottom, 5)
        }
    }
}

struct DayOfMonthCell_Previews: PreviewProvider {
    static var previews: some View {
        DayOfMonthCell(model: .init(state: .today,
                                    day: "31",
                                    events: 3))
            .previewLayout(.fixed(width: 53, height: 83))
            
    }
}
