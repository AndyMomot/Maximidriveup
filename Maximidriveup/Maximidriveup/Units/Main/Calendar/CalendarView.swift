//
//  CalendarView.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 17.04.2024.
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        ZStack {
            GradientBackground()
                .ignoresSafeArea()
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
