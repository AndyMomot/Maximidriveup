//
//  DefaultsService.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 16.04.2024.
//

import Foundation

final class DefaultsService {
    static let standard = UserDefaults.standard
    private init() {}
}

extension DefaultsService {
    static var flow: Flow {
        let name = standard.string(forKey: Keys.flow.rawValue) ?? ""
        return Flow(rawValue: name) ?? .onboarding
    }
    
    static func setFlow(_ flow: Flow) {
        standard.set(flow.rawValue, forKey: Keys.flow.rawValue)
    }
    
    static var userName: String {
        return standard.string(forKey: Keys.userName.rawValue) ?? ""
    }
    
    static func setUserName(_ name: String) {
        standard.set(name, forKey: Keys.userName.rawValue)
    }
}

extension DefaultsService {
    static func saveMemberItems(_ items: [HomeView.IncomeCostModel]) {
        if let data = try? JSONEncoder().encode(items) {
            standard.set(data, forKey: Keys.memberItems.rawValue)
        }
    }
    
    static func saveOrganizerItems(_ items: [HomeView.IncomeCostModel]) {
        if let data = try? JSONEncoder().encode(items) {
            standard.set(data, forKey: Keys.organizerItems.rawValue)
        }
    }
    
    static var memberItems: [HomeView.IncomeCostModel] {
        if let data = standard.object(forKey: Keys.memberItems.rawValue) as? Data {
            let items = try? JSONDecoder().decode([HomeView.IncomeCostModel].self, from: data)
            return items ?? []
        }
        return []
    }
    
    static var organizerItems: [HomeView.IncomeCostModel] {
        if let data = standard.object(forKey: Keys.organizerItems.rawValue) as? Data {
            let items = try? JSONDecoder().decode([HomeView.IncomeCostModel].self, from: data)
            return items ?? []
        }
        return []
    }
}

extension DefaultsService {
    static var getFinalNoteSections: [HomeView.FinalNodeSection] {
        if let data = standard.object(forKey: Keys.finalNote.rawValue) as? Data {
            let items = try? JSONDecoder().decode([HomeView.FinalNodeSection].self, from: data)
            return items ?? []
        }
        return []
    }
    
    static func saveFinalNote(section: HomeView.FinalNodeSection) {
        var sections = getFinalNoteSections
        sections.append(section)
        if let data = try? JSONEncoder().encode(sections) {
            standard.set(data, forKey: Keys.finalNote.rawValue)
        }
    }
    
    static func removeFinalNote(section: HomeView.FinalNodeSection) {
        var sections = getFinalNoteSections
        sections.removeAll(where: { $0.id == section.id })
        if let data = try? JSONEncoder().encode(sections) {
            standard.set(data, forKey: Keys.finalNote.rawValue)
        }
    }
    
    static var currency: Currency {
        let value = standard.string(forKey: Keys.currency.rawValue) ?? ""
        return .init(rawValue: value) ?? .usd
    }
    
    static func set(currency: Currency) {
        standard.set(currency.rawValue, forKey: Keys.currency.rawValue)
    }
}

extension DefaultsService {
    static var getCalendarEvents: [CustomCalendarView.EventModel] {
        if let data = standard.object(forKey: Keys.calendarEvent.rawValue) as? Data {
            let items = try? JSONDecoder().decode([CustomCalendarView.EventModel].self, from: data)
            return items ?? []
        }
        return []
    }
    
    static func saveCalendar(event: CustomCalendarView.EventModel) {
        var events = getCalendarEvents
        events.append(event)
        if let data = try? JSONEncoder().encode(events) {
            standard.set(data, forKey: Keys.calendarEvent.rawValue)
        }
    }
    
    static func removeCalendar(event: CustomCalendarView.EventModel) {
        var events = getCalendarEvents
        
        if let index = events.firstIndex(where: {$0.id == event.id}) {
            events.remove(at: index)
            
            if let data = try? JSONEncoder().encode(events) {
                standard.set(data, forKey: Keys.calendarEvent.rawValue)
            }
        }
    }
    
    static var getCalendarNotes: [NotesView.Note] {
        if let data = standard.object(forKey: Keys.calendarNote.rawValue) as? Data {
            let items = try? JSONDecoder().decode([NotesView.Note].self, from: data)
            return items ?? []
        }
        return []
    }
    
    static func saveCalendar(note: inout NotesView.Note) {
        var notes = getCalendarNotes
        if notes.count % 2 == 0 {
            note.style = .yellow
        } else {
            note.style = .black
        }
        notes.append(note)
        if let data = try? JSONEncoder().encode(notes) {
            standard.set(data, forKey: Keys.calendarNote.rawValue)
        }
    }
    
    static func removeCalendar(note: NotesView.Note) {
        var notes = getCalendarNotes
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes.remove(at: index)
            if let data = try? JSONEncoder().encode(notes) {
                standard.set(data, forKey: Keys.calendarNote.rawValue)
            }
        }
    }
}

// MARK: - Keys
extension DefaultsService {
    enum Keys: String {
        case flow
        case userName
        case memberItems
        case organizerItems
        case finalNote
        case currency
        case calendarEvent
        case calendarNote
    }
}

extension DefaultsService {
    enum Flow: String {
        case onboarding
        case privacyPolicy
        case main
    }
    
    enum Currency: String {
        case usd = "USD"
        case eur = "EUR"
        case uah = "UAH"
        
        var icon: String {
            switch self {
            case .uah:
                return "₴"
            case .usd:
                return "$"
            case .eur:
                return "€"
            }
        }
    }
}
