//
//  HomeView.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 17.04.2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            GradientBackground()
                .ignoresSafeArea()
            
            VStack {
                CustomSegmentControlView(
                    items: viewModel.segmentItems,
                    selectedItem: $viewModel.selectedSegment)
                .padding()
                
                Spacer()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
