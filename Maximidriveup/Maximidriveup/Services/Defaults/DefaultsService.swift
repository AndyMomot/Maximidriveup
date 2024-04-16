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
    static var isOnboarded: Bool {
        standard.bool(forKey: Keys.isOnboarded.rawValue)
    }
    
    static func isOnboarded(flag: Bool) {
        standard.set(flag, forKey: Keys.isOnboarded.rawValue)
    }
}

// MARK: - Keys
extension DefaultsService {
    enum Keys: String {
        case isOnboarded
    }
}
