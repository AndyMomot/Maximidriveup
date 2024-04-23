//
//  CalendarView.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 17.04.2024.
//

import SwiftUI

struct CalendarView: View {
    @StateObject private var viewModel = CalendarViewModel()
    
    var body: some View {
        ZStack {
            GradientBackground()
                .ignoresSafeArea(edges: .bottom)
            
            VStack(spacing: 20) {
                CustomSegmentControlView(
                    items: viewModel.segmentItems,
                    selectedItem: $viewModel.selectedSegment)
                .padding()
                
                switch viewModel.segmentType {
                case .calendar:
                    CustomCalendarView()
                case .notes:
                    EmptyView()
                }
                
                Spacer()
            }
            
        }
        .onChange(of: viewModel.selectedSegment) { newValue in
            guard let newSegment = CalendarView.Segment(rawValue: newValue) else { return }
            viewModel.segmentType = newSegment
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
