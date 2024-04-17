//
//  SettingsView.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 17.04.2024.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        ZStack {
            GradientBackground()
                .ignoresSafeArea()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
