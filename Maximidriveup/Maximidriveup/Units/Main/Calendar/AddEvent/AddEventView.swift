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
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2)
            
            VStack {
                HStack {
                    Spacer()
                    
                    VStack(spacing: 16) {
                        Text("Создание события")
                            .foregroundColor(.black)
                            .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 20))
                            .padding(.top)
                        
                        TextField(text: $eventName) {
                          Text("Название события")
                        }
                        
                        Spacer()
                    }
                }
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.1), radius: 3, y: -3)
                .frame(height: bounds.height * 0.3)
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
