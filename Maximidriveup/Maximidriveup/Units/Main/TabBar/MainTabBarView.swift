//
//  TabBarView.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 16.04.2024.
//

import SwiftUI

struct MainTabBarView: View {
    @EnvironmentObject var rootViewModel: RootContentView.RootContentViewModel
    @StateObject private var viewModel = TabBarViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            TabView(selection: $viewModel.selection) {
                HomeView()
                    .tag(TabBarSelectionView.home.rawValue)
                    .environmentObject(viewModel)
                
                CalendarView()
                    .tag(TabBarSelectionView.calendar.rawValue)
                    .environmentObject(viewModel)
                
                HelpView()
                    .tag(TabBarSelectionView.help.rawValue)
                
                SettingsView()
                    .tag(TabBarSelectionView.settings.rawValue)
            }
            .tableStyle(.inset)
            .overlay(alignment: .bottom) {
                CustomTabBarView(selectedItem: $viewModel.selection)
            }
            .padding(.bottom, -geometry.safeAreaInsets.bottom)
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBarView()
    }
}
