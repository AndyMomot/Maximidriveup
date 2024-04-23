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
        ZStack {
            ScrollView(showsIndicators: false) {
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
                    
                    VStack(alignment: .center, spacing: 20) {
                        // Week days
                        HStack(spacing: 13) {
                            Spacer(minLength: 0)
                            ForEach(viewModel.weekDays, id: \.self) { day in
                                Text(day)
                                    .foregroundColor(Colors.gray.swiftUIColor)
                                    .font(Fonts.SFProDisplay.medium.swiftUIFont(fixedSize: 13))
                                    .lineLimit(1)
                                Spacer(minLength: 0)
                            }
                        }
                        
                        // Calendar
                        VStack(alignment: .center, spacing: 20) {
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
                        
                        NextButtonView(title: "Создание события") {
                            viewModel.showCreateEvent.toggle()
                        }
                        
                        ForEach(0..<3) { _ in
                            Rectangle()
                                .frame(height: 95)
                                .foregroundColor(Colors.yellow.swiftUIColor)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                }
            }
            
            if viewModel.showCreateEvent {
                AddEventView()
                    .ignoresSafeArea()
            }
        }
    }
}

struct CustomCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomCalendarView()
    }
}
