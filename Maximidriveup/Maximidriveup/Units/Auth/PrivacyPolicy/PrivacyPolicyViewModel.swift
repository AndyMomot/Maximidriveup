//
//  PrivacyPolicyViewModel.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 16.04.2024.
//

import Foundation

extension PrivacyPolicyView {
    final class PrivacyPolicyViewModel: ObservableObject {
        @Published var isAgreed = false
        @Published var showRegistration = false
        let privacyURL = URL(string: "https://maximidriveup.info")
    }
}
