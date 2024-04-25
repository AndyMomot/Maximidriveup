//
//  AddEventView.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 23.04.2024.
//

import SwiftUI

struct AddEventView: View {
    @Binding var show: Bool
    var onCreate: () -> Void
    @StateObject private var viewModel = AddEventViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2)
                .onTapGesture {
                    show = false
                }
            
            VStack {
                Spacer()
                
                VStack {
                    HStack {
                        Spacer()
                        
                        ScrollView {
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
                                        TextField(text: $viewModel.eventName) {
                                            Text("Название события")
                                                .foregroundColor(.gray)
                                                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 15))
                                        }
                                            .foregroundColor(.black)
                                            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 15))
                                            .padding()
                                    )
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray, lineWidth: 1)
                                    .foregroundColor(Color.clear)
                                    .frame(height: 50)
                                    .overlay(
                                        TextField(text: $viewModel.eventDescription) {
                                            Text("Описание")
                                                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 15))
                                                .foregroundColor(.gray)
                                        }
                                            .foregroundColor(.black)
                                            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 15))
                                            .padding()
                                    )
                                
                                ZStack {
                                    Colors.labelReversed.swiftUIColor
                                        .cornerRadius(10)
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.gray, lineWidth: 1)
                                        .foregroundColor(Color.clear)
                                        .frame(height: 50)
                                        .overlay(
                                            DatePicker("Дата", selection: $viewModel.eventDate, in: Date()..., displayedComponents: .date)
                                                .datePickerStyle(.compact)
                                                .padding()
                                    )
                                }
                                
                                ZStack {
                                    Colors.labelReversed.swiftUIColor
                                        .cornerRadius(10)
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.gray, lineWidth: 1)
                                        .foregroundColor(Color.clear)
                                        .frame(height: 50)
                                        .overlay(
                                            DatePicker("Время начала", selection: $viewModel.startTime, in: Date()..., displayedComponents: .hourAndMinute)
                                                .datePickerStyle(.compact)
                                                .padding()
                                        )
                                }
                                
                                ZStack {
                                    Colors.labelReversed.swiftUIColor
                                        .cornerRadius(10)
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.gray, lineWidth: 1)
                                        .foregroundColor(Color.clear)
                                        .frame(height: 50)
                                        .overlay(
                                            DatePicker("Время конца", selection: $viewModel.finishTime, in: Date()..., displayedComponents: .hourAndMinute)
                                                .datePickerStyle(.compact)
                                                .padding()
                                        )
                                }
                                
                                HStack(spacing: .zero) {
                                    Text("Удалить после срабатывания?")
                                        .foregroundColor(.black)
                                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 14))
                                    Spacer()
                                    Toggle(isOn: $viewModel.isAutoDelete) {}
                                        .tint(.black)
                                        .frame(maxWidth: 42)
                                        .padding(.trailing)
                                }
                                
                                NextButtonView(title: "Создать событие") {
                                    viewModel.onCreateTapped { isSuccess in
                                        if isSuccess {
                                            onCreate()
                                            show = false
                                        }
                                    }
                                }
                            }
                        }
                        
                        Spacer()
                    }
                    .background {
                        GradientBackground()
                            .ignoresSafeArea(edges: .bottom)
                    }
                    .cornerRadius(30)
                    .shadow(color: .black.opacity(0.1), radius: 15, y: -15)
                    .frame(maxHeight: bounds.height * 0.6)
                }
            }
        }
    }
}

struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventView(show: .constant(false)) {}
            .ignoresSafeArea()
        
    }
}
