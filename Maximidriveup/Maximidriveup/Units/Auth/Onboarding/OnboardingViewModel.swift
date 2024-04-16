//
//  OnboardingViewModel.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 16.04.2024.
//

import Foundation

extension OnboardingView {
    enum ViewState {
        case first
        case second
        
        var backgroundColorName: String {
            switch self {
            case .first:
                return Colors.liteBlue.name
            case .second:
                return Colors.blue.name
            }
        }
        
        var imageName: String {
            switch self {
            case .first:
                return Asset.bolid.name
            case .second:
                return Asset.cart.name
            }
        }
        
        var imageXOffset: CGFloat {
            switch self {
            case .first:
                return -20
            case .second:
                return 20
            }
        }
        
        var title: String {
            switch self {
            case .first:
                return "Добро пожаловать в наше приложение!"
            case .second:
                return "Мы рады что Вы выбрали нас!"
            }
        }
        
        var subtitle: String {
            switch self {
            case .first:
                return "Мы предлагаем возможность создания персонального бюджета для каждого заезда или сезона."
            case .second:
                return "Теперь оценивайте эффективность своих затрат просто в своем смартфоне!"
            }
        }
    }
}
