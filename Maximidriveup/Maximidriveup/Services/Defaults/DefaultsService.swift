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

// MARK: - Keys
extension DefaultsService {
    enum Keys: String {
        case flow
        case userName
        case memberItems
        case organizerItems
    }
}

extension DefaultsService {
    enum Flow: String {
        case onboarding
        case privacyPollycy
        case main
    }
}
