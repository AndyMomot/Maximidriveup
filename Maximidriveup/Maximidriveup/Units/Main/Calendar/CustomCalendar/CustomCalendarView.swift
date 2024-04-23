//
//  CustomCalendarView.swift
//  TesejournerX
//
//  Created by Andrii Momot on 01.04.2024.
//

import SwiftUI

struct CustomCalendarView: View {

    @StateObject private var viewModel = CustomCalendarViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Month picker
            HStack {
                Button {
                    viewModel.addOrSubtractMonth(value: -1)
                } label: {
                    Asset.backButton.swiftUIImage
                }
                
                Spacer()
            
                VStack(alignment: .center, spacing: 5) {
                    Text(viewModel.date.toString(format: .llll).capitalized)
                        .foregroundColor(.black)
                        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 20))
                    
                    Text(viewModel.date.toString(format: .yyyy).capitalized)
                        .foregroundColor(.gray)
                        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 12))
                }
                
                Spacer()
                
                Button {
                    viewModel.addOrSubtractMonth(value: 1)
                } label: {
                    Asset.backButton.swiftUIImage
                        .rotationEffect(.degrees(180))
                }
            }
            .padding(.horizontal)
            
            VStack(alignment: .center, spacing: 5) {
                // Week days
                HStack(spacing: .zero) {
                    Spacer()
                    ForEach(viewModel.weekDays, id: \.self) { day in
                        Text(day)
                            .foregroundColor(Colors.gray.swiftUIColor)
                            .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 13))
                        Spacer()
                    }
                }
                
                // Calendar
                VStack(alignment: .center, spacing: 10) {
                    ForEach(0..<viewModel.numberOfRows, id: \.self) { row in
                        HStack(alignment: .center, spacing: 10) {
                            ForEach(0..<self.viewModel.daysInWeek, id: \.self) { column in
                                if let date = viewModel.dayOfMonthForTest(row: row, column: column).0 {
                                    let state = viewModel.dayOfMonthForTest(row: row, column: column).1
                                    let model = viewModel.createDayModel(for: date, state: state)
                                    DayOfMonthCell(model: model)
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            
            Spacer()
        }
    }
}

struct CustomCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomCalendarView()
    }
}
