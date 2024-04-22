//
//  HistoryViewModel.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 22.04.2024.
//

import Foundation

extension HistoryView {
    final class HistoryViewModel: ObservableObject {
        @Published var sections: [HomeView.FinalNodeSection] = []
        @Published var showDelete = false
        @Published var sectionToDelete: HomeView.FinalNodeSection? = nil
        
        func getSections() {
            let sections = DefaultsService.getFinalNoteSections.sorted(by: {
                $0.date > $1.date
            })
            self.sections = sections
        }
        
        func deleteSection() {
            guard let section = self.sectionToDelete else { return }
            DispatchQueue.main.async {
                DefaultsService.removeFinalNote(section: section)
                self.getSections()
            }
        }
    }
}
