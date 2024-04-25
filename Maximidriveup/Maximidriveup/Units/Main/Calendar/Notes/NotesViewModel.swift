//
//  NotesViewModel.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 25.04.2024.
//

import Foundation

extension NotesView {
    final class NotesViewModel: ObservableObject {
        @Published var notes: [Note] = []
        
        func getNotes() {
            DispatchQueue.main.async {
                self.notes = DefaultsService.getCalendarNotes
            }
        }
    }
}

extension NotesView {
    struct Note: Codable, Identifiable {
        private(set) var id = UUID()
        private(set) var date = Date()
        var title: String
        var description: String
        var style: Style = .black
        
        enum Style: Codable {
            case black
            case yellow
        }
    }
}
