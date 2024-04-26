//
//  HelpView.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 17.04.2024.
//

import SwiftUI

struct HelpView: View {
    @StateObject private var viewModel = HelpViewModel()
    
    var body: some View {
        ZStack {
            GradientBackground()
                .ignoresSafeArea(edges: .bottom)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 10) {
                    ForEach(viewModel.tips) { advice in
                        AdviceCell(advice: advice)
                    }
                }
            }
            .padding()
        }
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
