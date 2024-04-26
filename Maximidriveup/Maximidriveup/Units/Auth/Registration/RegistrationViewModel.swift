//
//  RegistrationViewModel.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 16.04.2024.
//

import Foundation

extension RegistrationView {
    final class RegistrationViewModel: ObservableObject {
        @Published var name = ""
        
        var isValidName: Bool {
            name.count > .zero
        }
        
        func saveName() {
            var user = SettingsView.User(firstName: name)
            DefaultsService.saveUser(user)
        }
    }
}
