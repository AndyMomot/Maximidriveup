//
//  AddEventView.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 23.04.2024.
//

import SwiftUI

struct AddEventView: View {
    @State private var eventName = ""
    @State private var eventDescription = ""
    @State private var date = ""
    @State private var start = ""
    @State private var finish = ""
    
    @State private var showDatePicker = false
    @State private var selectedDate = Date()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2)
            
            VStack {
                Spacer()
                
                VStack {
                    HStack {
                        Spacer()
                        
                        VStack(spacing: 16) {
                            Text("Создание события")
                                .foregroundColor(.black)
                                .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 20))
                                .padding(.top)
                            
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray, lineWidth: 1)
                                .foregroundColor(Color.clear)
                                .frame(height: 50)
                                .overlay(
                                    TextField(text: $eventName) {
                                        Text("Название события")
                                    }
                                        .padding()
                                )
                            
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray, lineWidth: 1)
                                .foregroundColor(Color.clear)
                                .frame(height: 50)
                                .overlay(
                                    TextField(text: $eventDescription) {
                                        Text("Описание")
                                    }
                                        .padding()
                                )
                            
                            if showDatePicker {
                                DatePicker("", selection: $selectedDate, in: Date()..., displayedComponents: .date)
                                    .datePickerStyle(.graphical)
                                    .onChange(of: selectedDate) { newValue in
                                        showDatePicker.toggle()
                                }
                            } else {
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray, lineWidth: 1)
                                    .foregroundColor(Color.clear)
                                    .frame(height: 50)
                                    .overlay(
                                        HStack {
                                            Text(selectedDate.toString())
                                            
                                            Spacer()
                                            
                                            Button {
                                                showDatePicker.toggle()
                                            } label: {
                                                Asset.calendar.swiftUIImage
                                            }
                                            
                                        }
                                            .padding()
                                    )
                            }
                            Spacer()
                        }
                        
                        Spacer()
                    }
                    .background(Color.white)
                    .cornerRadius(30)
                    .shadow(color: .black.opacity(0.1), radius: 15, y: -15)
                    .frame(height: bounds.height * 0.76)
                }
            }
        }
    }
}

struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventView()
            .ignoresSafeArea()
        
    }
}
