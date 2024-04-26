//
//  CalendarNoteCell.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 25.04.2024.
//

import SwiftUI

struct CalendarNoteCell: View {
    var note: NotesView.Note
    
    var body: some View {
        VStack(spacing: 5) {
            VStack(spacing: 3) {
                HStack {
                    Text(note.date.toString(format: .ddMMYYHHmm))
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    Spacer(minLength: .zero)
                }
                
                HStack {
                    Text(note.title)
                    Spacer(minLength: .zero)
                }
            }
            .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 18))
            
            HStack {
                Text(note.description)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 13))
                    .lineLimit(.random(in: 4...9))
                Spacer(minLength: .zero)
            }
        }
        .multilineTextAlignment(.leading)
        .padding()
        .background {
            note.style == .black ? Color.black : Colors.yellow.swiftUIColor
        }
        .foregroundColor(note.style == .black ? Color.white : Color.black)
        .cornerRadius(30)
    }
}

struct CalendarNoteCell_Previews: PreviewProvider {
    static var previews: some View {
        CalendarNoteCell(note: .init(
            title: "Подготовка. Советы для Участников",
            description: "Ознакомьтесь с трассой: изучите каждый поворот, каждый подъем и спуск, чтобы быть готовыми к любым вызовам на пути к победе. Проверьте оборудование: удостоверьтесь, что ваш автомобиль или мотоцикл находится в идеальном состоянии, проведя тщательную проверку технического состояния. Организуйте стратегию и планы действий, а также постарайтесь предвидеть возможные сценарии. Подготовьте себя ментально:оставайтесь спокойными и сосредоточенными. email@gmail.com",
            style: .yellow))
    }
}
