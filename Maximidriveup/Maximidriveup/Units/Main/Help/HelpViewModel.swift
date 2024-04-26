//
//  HelpViewModel.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 26.04.2024.
//

import Foundation

extension HelpView {
    final class HelpViewModel: ObservableObject {
        @Published var tips: [AdviceModel] = [
            .init(title: "Как зарегистрироваться на участие в конкретном соревновании или событии?",
                  description: "Как зарегистрироваться на участие в конкретном соревновании или событии?"),
            .init(title: "Есть ли возможность подать заявку на аккредитацию для прессы или фотографов на события?",
                  description: "Есть ли возможность подать заявку на аккредитацию для прессы или фотографов на события?")
        ]
    }
}

extension HelpView {
    struct AdviceModel: Identifiable {
        private(set) var id = UUID()
        var title, description: String
    }
}
