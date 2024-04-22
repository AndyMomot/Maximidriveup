//
//  Date+Additions.swift
//  TesejournerX
//
//  Created by Andrii Momot on 25.03.2024.
//

import Foundation

extension Date {
    func toString(format: Format = .ddMMyy) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
}

extension Date {
    enum Format: String {
        case ddMMyy = "dd.MM.yyyy"
    }
}
