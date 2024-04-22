//
//  HistoryView.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 22.04.2024.
//

import SwiftUI

struct HistoryView: View {
    @StateObject private var viewModel = HistoryViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 10) {
                        if viewModel.sections.isEmpty {
                            Text("Пусто")
                                .foregroundColor(.black)
                                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 14))
                        } else {
                            ForEach(viewModel.sections) { section in
                                HistorySectionCell(section: section) { // on delete
                                    viewModel.sectionToDelete = section
                                    viewModel.showDelete.toggle()
                                }
                            }
                        }
                    }
                }
                .padding()
                
                // Delete Alert
                if viewModel.showDelete {
                    ZStack {
                        Color.black.opacity(0.3)
                        DeleteHistoryView(isAppeared: $viewModel.showDelete) {
                            viewModel.deleteSection()
                        }
                        .padding()
                    }
                    .ignoresSafeArea()
                }
            }
            .navigationBarItems(leading:
                                    Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Asset.leftTriangle.swiftUIImage
            }
                .navigationBarBackButtonHidden(true)
            )
        }
        .onAppear {
            viewModel.getSections()
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
