//
//  CalendarViewModel.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 23.04.2024.
//

import Foundation

extension CalendarView {
    final class CalendarViewModel: ObservableObject {
        let segmentItems = Segment.allCases.sorted(by: {
            $0.rawValue < $1.rawValue
        }).map { $0.title }
        
        @Published var selectedSegment = 0
        @Published var segmentType: Segment = .calendar
    }
}

extension CalendarView {
    enum Segment: Int, CaseIterable {
        case calendar = 0
        case notes = 1
        
        var title: String {
            switch self {
            case .calendar:
                return "Календарь"
            case .notes:
                return "Заметки"
            }
        }
    }
}
