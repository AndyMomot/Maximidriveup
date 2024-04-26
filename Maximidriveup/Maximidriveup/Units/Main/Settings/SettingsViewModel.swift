//
//  SettingsViewModel.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 26.04.2024.
//

import Foundation

extension SettingsView {
    final class SettingsViewModel: ObservableObject {
        @Published var imageData: Data = .init()
        @Published var showGallery = false
        @Published var user = User()
        @Published var currency: DefaultsService.Currency = .usd
        
        func saveImage() {
            FileManagerService().saveFile(data: self.imageData, forKey: .profileIcon)
        }
        
        func getImage() {
            DispatchQueue.main.async {
                if let data = FileManagerService().getFile(forKey: .profileIcon) {
                    self.imageData = data
                }
            }
        }
        
        func getUser() {
            DispatchQueue.main.async {
                if let user = DefaultsService.getUser() {
                    self.user = user
                }
            }
        }
        
        func saveUser() {
            DefaultsService.saveUser(self.user)
        }
        
        func saveCurrency() {
            DefaultsService.set(currency: currency)
        }
        
        func onSaveTapped() {
            DispatchQueue.main.async {
                self.saveImage()
                self.saveUser()
                self.saveCurrency()
            }
        }
    }
}

extension SettingsView {
    struct User: Codable {
        var firstName: String = ""
        var lastName: String = ""
        var year: String = ""
        var email: String = ""
        var country: String = ""
    }
}
