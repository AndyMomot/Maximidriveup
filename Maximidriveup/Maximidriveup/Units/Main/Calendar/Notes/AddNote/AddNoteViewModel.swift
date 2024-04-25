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
        
        func onSaveTapped(note: NotesView.Note?) {
            guard let note = note else {
                saveNote()
                return
            }
            
            update(note: note)
        }
        
        func saveNote() {
            DispatchQueue.main.async {
                if self.isValidFields() {
                    var note = NotesView.Note(title: self.title,
                                              description: self.description)
                    DefaultsService.saveCalendar(note: &note)
                }
            }
        }
        
        func update(note: NotesView.Note) {
            DispatchQueue.main.async {
                if self.isValidFields() {
                    var notes = DefaultsService.getCalendarNotes
                    if let index = notes.firstIndex(where: {
                        $0.id == note.id
                    }) {
                        notes[index] = note
                        DefaultsService.saveCalendar(notes: notes)
                    }
                }
            }
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
