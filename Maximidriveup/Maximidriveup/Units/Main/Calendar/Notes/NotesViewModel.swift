//
//  NotesViewModel.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 25.04.2024.
//

import Foundation

extension NotesView {
    final class NotesViewModel: ObservableObject {
        @Published var notesLeading: [Note] = []
        @Published var notesTrailing: [Note] = []
        @Published var showAddNote = false
        
        var selectedNote: Note?
        
        func getNotes() {
            DispatchQueue.main.async {
                self.notesLeading.removeAll()
                self.notesTrailing.removeAll()
                
                let notes = DefaultsService.getCalendarNotes
                for index in 0..<notes.count {
                    if index % 2 == 0 {
                        self.notesLeading.append(notes[index])
                    } else {
                        self.notesTrailing.append(notes[index])
                    }
                }
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
