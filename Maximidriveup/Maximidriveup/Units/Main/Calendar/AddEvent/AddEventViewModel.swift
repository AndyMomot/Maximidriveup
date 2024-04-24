//
//  AddEventViewModel.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 24.04.2024.
//

import Foundation

extension AddEventView {
    final class AddEventViewModel: ObservableObject {
        @Published var eventName = ""
        @Published var eventDescription = ""
        @Published var eventDate = Date()
        @Published var startTime = Date()
        @Published var finishTime = Date()
        @Published var isAutoDelete = true
        
        func onCreateTapped(completion: @escaping (Bool) -> Void) {
            if isValidFields() {
                let model = CustomCalendarView.EventModel(
                    name: eventName,
                    description: eventDescription,
                    date: eventDate,
                    start: startTime,
                    end: finishTime,
                    autoDelete: isAutoDelete
                )
                
                DispatchQueue.main.async {
                    DefaultsService.saveCalendar(event: model)
                    completion(true)
                }
            } else {
                completion(false)
            }
        }
    }
}

private extension AddEventView.AddEventViewModel {
    func isValidFields() -> Bool {
        let isValidEventName = !eventName.isEmpty
        let isValidEventDescription = !eventDescription.isEmpty
        var isValidTime: Bool {
            startTime < Date() && startTime <= finishTime
        }
        return isValidEventName && isValidEventDescription && isValidTime
    }
}
