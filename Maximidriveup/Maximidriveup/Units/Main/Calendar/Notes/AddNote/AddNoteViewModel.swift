//
//  AddNoteViewModel.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 25.04.2024.
//

import Foundation

extension AddNoteView {
    final class AddNoteViewModel: ObservableObject {
        @Published var title = ""
        @Published var description = ""
        
        func setUI(with note: NotesView.Note?) {
            guard let note = note else { return }
            title = note.title
            description = note.description
        }
        
        func onSaveTapped(note: NotesView.Note?) -> Bool {
            guard let note = note else {
                return saveNote()
            }
            
            return update(note: note)
        }
        
        func saveNote() -> Bool {
            if self.isValidFields() {
                let isBlackStyle = Bool.random()
                let note = NotesView.Note(title: self.title,
                                          description: self.description,
                                          style: isBlackStyle ? .black : .yellow
                )
                DefaultsService.saveCalendar(note: note)
                return true
            }
            return false
        }
        
        func update(note: NotesView.Note) -> Bool {
            if self.isValidFields() {
                var notes = DefaultsService.getCalendarNotes
                if let index = notes.firstIndex(where: {
                    $0.id == note.id
                }) {
                    notes[index] = note
                    DefaultsService.saveCalendar(notes: notes)
                    return true
                }
            }
            return false
        }
        
        func isValidFields() -> Bool {
            return !title.isEmpty && !description.isEmpty
        }
        
        func delete(note: NotesView.Note?) {
            DispatchQueue.main.async {
                self.title = ""
                self.description = ""
                
                guard let note = note else { return }
                DefaultsService.removeCalendar(note: note)
            }
        }
    }
}
