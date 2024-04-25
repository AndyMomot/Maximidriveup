//
//  AddNoteView.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 25.04.2024.
//

import SwiftUI

struct AddNoteView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = AddNoteViewModel()
    var note: NotesView.Note? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                ScrollView {
                    VStack {
                        VStack(alignment: .leading) {
                            Text("Введите текст:")
                                .font(.headline)
                                .padding(.bottom, 4)
                            
                            ZStack(alignment: .topLeading) {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                                TextEditor(text: $viewModel.title)
                                    .padding(8)
                            }
                            .frame(minHeight: 100)
                        }
                        .padding()
                    }
                }
            }
            .navigationBarItems(
                leading:
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Asset.leftTriangle.swiftUIImage
                            Text(note?.title.prefix(10) ?? "Новая заметка")
                                .foregroundColor(.black)
                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 17))
                        }
                    }
                    .navigationBarBackButtonHidden(true)
            )
        }
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView()
    }
}
