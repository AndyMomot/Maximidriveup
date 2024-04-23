//
//  Date+Additions.swift
//  TesejournerX
//
//  Created by Andrii Momot on 25.03.2024.
//

import Foundation

extension Date {
    func toString(format: Format = .ddMMyyyy) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
    
    func addOrSubtract(component: Calendar.Component, value: Int) -> Date {
        let calendar = Calendar.current
        if let modifiedDate = calendar.date(byAdding: component, value: value, to: self) {
            return modifiedDate
        } else {
            return self
        }
    }
    
    func isToday() -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }
    
    func getCalendarComponet(period component: Calendar.Component) -> Int {
        let calendar = Calendar.current
        return calendar.component(component, from: self)
    }
    
    func isWeekend() -> Bool {
        let calendar = Calendar(identifier: .iso8601)
        let weekday = calendar.component(.weekday, from: self)
        return weekday == 7 || weekday == 1 // Суббота (7) и воскресенье (1) - выходные дни в Польше
    }
}

extension Date {
    enum Format: String {
        case ddMMyyyy = "dd.MM.yyyy"
        case ddMMyy = "dd.MM.yy"
        case llll = "LLLL"
        case yyyy = "yyyy"
        case mmYY = "MM.yy"
    }
}
