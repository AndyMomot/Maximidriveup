//
//  CustomCalendarViewModel.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 23.04.2024.
//

import Foundation
import SwiftUI

extension CustomCalendarView {
    final class CustomCalendarViewModel: ObservableObject {
        @Published var date = Date()
        @Published var showCreateEvent = false
        @Published var events: [CustomCalendarView.EventModel] = []
        
        let weekDays = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
        let calendar: Calendar = {
            var calendar = Calendar.current
            calendar.locale = Locale(identifier: "ru_RU")
            calendar.firstWeekday = 2 // Понедельник
            return calendar
        }()
        let numberOfRows = 5
        let daysInWeek = 7
        
        // Calendar
        func addOrSubtractMonth(value: Int) {
            date = date.addOrSubtract(component: .month, value: value)
            getCalendarEvents()
        }
        
        // Функция для получения дня месяца для заданного ряда и столбца в календаре
        func dayOfMonthFor(row: Int, column: Int) -> (Date?, DayOfMonthModel.State) {
            
            // Получаем первый день месяца
            let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date))!
            
            // Определяем день недели для первого дня месяца
            let firstWeekdayOfMonth = calendar.component(.weekday, from: firstDayOfMonth)
            
            // Определяем количество дней в предыдущем месяце
            let previousMonth = calendar.date(byAdding: .month, value: -1, to: firstDayOfMonth)!
            let daysInPreviousMonth = calendar.range(of: .day, in: .month, for: previousMonth)!.count
            
            // Определяем количество дней в текущем месяце
            let daysInMonth = calendar.range(of: .day, in: .month, for: firstDayOfMonth)!.count
            
            // Вычисляем порядковый номер дня для текущей ячейки
            let day = (row * daysInWeek) + column - firstWeekdayOfMonth + 3
            
            // Проверяем, принадлежит ли день месяцу, если да, то возвращаем его номер, если нет, то возвращаем номер дня предыдущего или следующего месяца
            if day >= 1 && day <= daysInMonth {
                let dateString = "\(day)." + date.toString(format: .mmYY)
                let date = dateString.toDateWith(format: .ddMMyy)
                let isToday = date?.isToday() ?? false
                
                var itemState: DayOfMonthModel.State = .today
                if isToday {
                    itemState = .today
                } else {
                    itemState = .weekDay
                }
                
                return (date, itemState)
            } else if day <= 0 {
                // outOfMonth
                let previousMonth = date.addOrSubtract(component: .month, value: -1)
                let dateString = "\(daysInPreviousMonth + day)." + previousMonth.toString(format: .mmYY)
                let itemState: DayOfMonthModel.State = .outOfMonth
                let date = dateString.toDateWith(format: .ddMMyy)
                return (date, itemState)
            } else {
                // outOfMonth
                let nextMonth = date.addOrSubtract(component: .month, value: 1)
                let dateString = "\(day - daysInMonth)." + nextMonth.toString(format: .mmYY)
                let itemState: DayOfMonthModel.State = .outOfMonth
                let date = dateString.toDateWith(format: .ddMMyy)
                return (date, itemState)
            }
        }
        
        func createDayModel(for date: Date, state: DayOfMonthModel.State) -> DayOfMonthModel {
            let day = date.getCalendarComponent(period: .day)
            let numberOfEvents = DefaultsService.getCalendarEvents.filter {
                $0.date.toString(format: .ddMMyy) == date.toString(format: .ddMMyy)
            }.count
            return .init(state: state, day: "\(day)", events: numberOfEvents)
        }
        
        func getCalendarEvents() {
            deleteInvalidEvents()
            events = DefaultsService.getCalendarEvents.filter {
                $0.date.toString(format: .mmYY) == date.toString(format: .mmYY)
            }.sorted(by: {
                let firstFinish = combine(date: $0.date, andTime: $0.end)
                let secondFinish = combine(date: $1.date, andTime: $1.end)
                return firstFinish < secondFinish
            })
        }
        
        func delete(event: CustomCalendarView.EventModel) {
            DispatchQueue.main.async {
                DefaultsService.removeCalendar(event: event)
                self.getCalendarEvents()
            }
        }
        
        func deleteInvalidEvents()  {
            DefaultsService.getCalendarEvents.filter {
                let finish = combine(date: $0.date, andTime: $0.end)
                return finish < Date() && $0.autoDelete
            }.forEach { event in
                self.delete(event: event)
            }
        }
        
        private func combine(date: Date, andTime: Date) -> Date {
            // Ваши объекты Date
            let date1 = date // Первая дата
            let date2 = andTime // Вторая дата

            // Создание календаря
            let calendar = Calendar.current

            // Извлечение компонентов даты из первого объекта Date
            let date1Components = calendar.dateComponents([.year, .month, .day], from: date1)

            // Извлечение компонентов времени из второго объекта Date
            let date2Components = calendar.dateComponents([.hour, .minute, .second], from: date2)

            // Создание новых компонентов даты и времени
            var combinedComponents = DateComponents()
            combinedComponents.year = date1Components.year
            combinedComponents.month = date1Components.month
            combinedComponents.day = date1Components.day
            combinedComponents.hour = date2Components.hour
            combinedComponents.minute = date2Components.minute
            combinedComponents.second = date2Components.second
            
            return calendar.date(from: combinedComponents) ?? Date()
        }
    }
}

extension CustomCalendarView {
    struct DayOfMonthModel {
        var state: State
        var day: String
        var events: Int
        
        enum State {
            case today
            case weekDay
            case outOfMonth
        }
        
        var foregroundColor: Color {
            switch state {
            case .today:
                return .white
            case .weekDay:
                return .black
            case .outOfMonth:
                return Colors.gray.swiftUIColor
            }
        }
        
        var font: SwiftUI.Font {
            switch state {
            case .today:
                return Fonts.SFProDisplay.bold.swiftUIFont(size: 15)
            default:
                return Fonts.SFProDisplay.medium.swiftUIFont(size: 15)
            }
        }
    }
    
    struct EventModel: Codable, Identifiable {
        var id = UUID()
        var name, description: String
        var date, start, end: Date
        var autoDelete: Bool
    }
}
