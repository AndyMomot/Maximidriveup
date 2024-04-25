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
    }
}
