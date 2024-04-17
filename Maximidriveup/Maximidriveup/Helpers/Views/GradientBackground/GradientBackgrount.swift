//
//  GradientBackground.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 17.04.2024.
//

import SwiftUI

struct GradientBackground: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                .white,
                Colors.liteGray.swiftUIColor
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

struct GradientBackgrount_Previews: PreviewProvider {
    static var previews: some View {
        GradientBackground()
    }
}
