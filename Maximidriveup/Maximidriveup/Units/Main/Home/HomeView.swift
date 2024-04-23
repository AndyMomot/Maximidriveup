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
        GeometryReader { geometry in
            ZStack {
                GradientBackground()
                    .ignoresSafeArea(edges: .bottom)
                    .onTapGesture {
                        UIApplication.shared.sendAction(
                            #selector(UIResponder.resignFirstResponder),
                            to: nil,
                            from: nil,
                            for: nil)
                    }
                
                VStack(spacing: 20) {
                    HStack(spacing: 1) {
                        CustomSegmentControlView(
                            items: viewModel.segmentItems,
                            selectedItem: $viewModel.selectedSegment)
                        
                        Button {
                            viewModel.showHistory.toggle()
                        } label: {
                            Asset.history.swiftUIImage
                                .padding(.bottom, 6)
                        }
                    }
                    
                    switch viewModel.segmentType {
                    case .member:
                        MemberOrganizerContentView(
                            items: viewModel.memberItems) { index in
                                viewModel.removeMemberItem(at: index)
                            } onSumChanged: { index, sum in
                                viewModel.updateMemberItem(sum: sum, at: index)
                            }
                    case .organizer:
                        MemberOrganizerContentView(
                            items: viewModel.organizerItems) { index in
                                viewModel.removeOrganizerItem(at: index)
                            } onSumChanged: { index, sum in
                                viewModel.updateOrganizerItem(sum: sum, at: index)
                            }
                    case .final:
                        FinalContentView(
                            memberItems: viewModel.memberItems,
                            organizerItems: viewModel.organizerItems) { income in
                                viewModel.income = income
                            }
                    }
                    
                    switch viewModel.segmentType {
                    case .final:
                        HStack(spacing: 10) {
                            NextButtonView(title: "Удалить") {
                                viewModel.deleteNote()
                            }
                            
                            NextButtonView(title: "Сохранить") {
                                viewModel.saveNote()
                            }
                        }
                        .padding(.bottom, geometry.size.height * 0.04)
                    default:
                        NextButtonView(title: "Добавить поле") {
                            viewModel.showAddItem.toggle()
                        }
                        .padding(.bottom, geometry.size.height * 0.04)
                    }
                }
                .padding()
                
                if viewModel.showAddItem {
                    AddFieldView(isAppeared: $viewModel.showAddItem) { item in
                        switch viewModel.segmentType {
                        case .member:
                            viewModel.addMemberItem(item)
                        case .organizer:
                            viewModel.addOrganizerItem(item)
                        default:
                            break
                        }
                    }
                    .ignoresSafeArea()
                }
            }
            .onChange(of: viewModel.selectedSegment) { newValue in
                guard let newSegment = HomeView.Segment(rawValue: newValue) else { return }
                viewModel.segmentType = newSegment
            }
            .onAppear {
                viewModel.setItems()
            }
            .fullScreenCover(isPresented: $viewModel.showHistory) {
                HistoryView()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
