//
//  AddNoteView.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 25.04.2024.
//

import SwiftUI

struct AddNoteView: View {
    var note: NotesView.Note? = nil
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = AddNoteViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                GradientBackground()
                    .ignoresSafeArea()
                
                VStack {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 10) {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray, lineWidth: 1)
                                .foregroundColor(Color.clear)
                                .background(Color.white)
                                .frame(height: 50)
                                .overlay(
                                    TextField(text: $viewModel.title) {
                                        Text("Название события")
                                            .foregroundColor(.gray)
                                            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 15))
                                    }
                                        .foregroundColor(.black)
                                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 15))
                                        .padding()
                                )
                            Text((note?.date ?? Date()).toString(format: .ddMMYYHHmm))
                                .foregroundColor(.black)
                                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 13))
                            
                            ZStack(alignment: .topLeading) {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                                    .background(Color.white)
                                
                                TextEditor(text: $viewModel.description)
                                    .padding(8)
                                    .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 15))
                            }
                            .frame(minHeight: 100)
                        }
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 12) {
                        NextButtonView(title: "Удалить") {
                            viewModel.delete(note: note)
                        }
                        
                        NextButtonView(title: "Сохранить") {
                            viewModel.onSaveTapped(note: note)
                        }
                    }
                }
                .padding()
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
        .onAppear {
            viewModel.setUI(with: note)
        }
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView()
    }
}
