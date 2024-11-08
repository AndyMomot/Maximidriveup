//
//  UserModel.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 16.04.2024.
//

import Foundation

final class UserModel {
    
    static let shared = UserModel()
    
    private init() {}
    
    var name: String {
        DefaultsService.getUser()?.firstName ?? ""
    }
    
    var memberItems: [HomeView.IncomeCostModel] {
        DefaultsService.memberItems
    }
    
    var organizerItems: [HomeView.IncomeCostModel] {
        DefaultsService.organizerItems
    }
}
