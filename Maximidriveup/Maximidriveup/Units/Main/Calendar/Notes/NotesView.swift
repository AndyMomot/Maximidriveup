//
//  NotesView.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 25.04.2024.
//

import SwiftUI

struct NotesView: View {
    @StateObject var viewModel = NotesViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                if viewModel.notesLeading.isEmpty {
                    Text("Пусто")
                        .foregroundColor(.black)
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 14))
                } else {
                    HStack(alignment: .center, spacing: 10) {
                        if !viewModel.notesLeading.isEmpty {
                            VStack(spacing: 10) {
                                ForEach(viewModel.notesLeading) { note in
                                    Button {
                                        viewModel.selectedNote = note
                                        viewModel.showAddNote.toggle()
                                    } label: {
                                        CalendarNoteCell(note: note)
                                    }
                                }
                                Spacer(minLength: .zero)
                            }
                        }
                        
                        if !viewModel.notesTrailing.isEmpty {
                            VStack(spacing: 10) {
                                ForEach(viewModel.notesTrailing) { note in
                                    Button {
                                        viewModel.selectedNote = note
                                        viewModel.showAddNote.toggle()
                                    } label: {
                                        CalendarNoteCell(note: note)
                                    }
                                }
                                Spacer(minLength: .zero)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
                
            
            VStack(alignment: .trailing) {
                Spacer()
                HStack {
                    Spacer()
                    
                    ZStack {
                        Circle()
                            .foregroundColor(Colors.yellow.swiftUIColor)
                            .frame(width: 71, height: 71)
                        
                        Button {
                            viewModel.selectedNote = nil
                            viewModel.showAddNote.toggle()
                        } label: {
                            Asset.pencil.swiftUIImage
                            
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            viewModel.getNotes()
        }
        .fullScreenCover(isPresented: $viewModel.showAddNote) {
            AddNoteView(note: viewModel.selectedNote) {
                viewModel.getNotes()
            }
        }
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
    }
}
