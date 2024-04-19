//
//  HomeViewModel.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 17.04.2024.
//

import Foundation

extension HomeView {
    final class HomeViewModel: ObservableObject {
        let segmentItems = Segment.allCases.sorted(by: {
            $0.rawValue < $1.rawValue
        }).map { $0.title }
        
        @Published var selectedSegment = 0
        @Published var segmentType: Segment = .member
        
        @Published var memberItems: [HomeView.IncomeCostModel] = []
        @Published var organizerItems: [HomeView.IncomeCostModel] = []
        
        @Published var showAddItem = false
        
        func saveMemberItems() {
            DispatchQueue.main.async {
                DefaultsService.saveMemberItems(self.memberItems)
                self.memberItems = UserModel.shared.memberItems
            }
        }
        
        func saveOrganizerItems() {
            DispatchQueue.main.async {
                DefaultsService.saveOrganizerItems(self.organizerItems)
                self.organizerItems = UserModel.shared.organizerItems
            }
        }
        
        func addMemberItem(_ item: HomeView.IncomeCostModel) {
            memberItems.append(item)
            saveMemberItems()
        }
        
        func addOrganizerItem(_ item: HomeView.IncomeCostModel) {
            organizerItems.append(item)
            saveOrganizerItems()
        }
        
        func updateMemberItem(sum: Int, at index: Int) {
            memberItems[index].sum = sum
            saveMemberItems()
        }
        
        func updateOrganizerItem(sum: Int, at index: Int) {
            organizerItems[index].sum = sum
            saveOrganizerItems()
        }
        
        func removeMemberItem(at index: Int) {
            memberItems.remove(at: index)
            saveMemberItems()
        }
        
        func removeOrganizerItem(at index: Int) {
            organizerItems.remove(at: index)
            saveOrganizerItems()
        }
        
        func setItems() {
            memberItems = UserModel.shared.memberItems
            organizerItems = UserModel.shared.organizerItems
        }
    }
    
    enum Segment: Int, CaseIterable {
        case member = 0
        case organizer = 1
        case final = 2
        
        var title: String {
            switch self {
            case .member:
                return "Учасник"
            case .organizer:
                return "Организатор"
            case .final:
                return "Финал"
            }
        }
    }
}

extension HomeView {
    struct IncomeCostModel: Identifiable, Hashable, Codable {
        var id = UUID()
        var type: ItemType
        var title: String
        var sum: Int = .zero
    }
}

extension HomeView.IncomeCostModel {
    enum ItemType: Codable {
        case income
        case cost
    }
}

extension HomeView {
    struct FinalIncomeCostModel {
        var title: String
        var topFieldName: String
        var bottomFieldName: String
        var topFieldValue: Double
        var bottomFieldValue: Double
        var showTopFieldDollarMark = true
        var showBottomFieldDollarMark = true
    }
}
