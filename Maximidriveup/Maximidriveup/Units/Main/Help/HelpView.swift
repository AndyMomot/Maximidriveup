//
//  HelpView.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 17.04.2024.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        ZStack {
            GradientBackground()
                .ignoresSafeArea()
        }
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
