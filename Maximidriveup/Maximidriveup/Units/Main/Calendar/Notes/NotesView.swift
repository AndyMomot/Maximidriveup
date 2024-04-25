//
//  NotesView.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 25.04.2024.
//

import SwiftUI

struct NotesView: View {
    @StateObject var viewModel = NotesViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.notes) { note in
                    CalendarNoteCell(note: note)
                }
            }
        }
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
    }
}
