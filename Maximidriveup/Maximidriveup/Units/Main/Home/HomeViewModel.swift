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
        @Published var income: Double = .zero
        
        @Published var showAddItem = false
        @Published var showHistory = false
        
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
            if (memberItems.count - 1) >= index {
                memberItems[index].sum = sum
                saveMemberItems()
            }
        }
        
        func updateOrganizerItem(sum: Int, at index: Int) {
            if (organizerItems.count - 1) >= index {
                organizerItems[index].sum = sum
                saveOrganizerItems()
            }
        }
        
        func removeMemberItem(at index: Int) {
            if (memberItems.count - 1) >= index {
                memberItems.remove(at: index)
                saveMemberItems()
            }
        }
        
        func removeOrganizerItem(at index: Int) {
            if (organizerItems.count - 1) >= index {
                organizerItems.remove(at: index)
                saveOrganizerItems()
            }
        }
        
        func setItems() {
            memberItems = UserModel.shared.memberItems
            organizerItems = UserModel.shared.organizerItems
        }
        
        // MARK: Final -
        func deleteNote() {
            memberItems.removeAll()
            organizerItems.removeAll()
            
            if memberItems.isEmpty {
                saveMemberItems()
            }
            
            if organizerItems.isEmpty {
                saveOrganizerItems()
            }
        }
        
        func saveNote() {
            var memberCosts: Int {
                let costsArray = memberItems.filter { $0.type == .cost }
                if costsArray.isEmpty {
                    return .zero
                }
                return costsArray.reduce(0) { $0 + $1.sum }
            }
            
            var memberIncome: Int {
                let incomeArray = memberItems.filter { $0.type == .income }
                if incomeArray.isEmpty {
                    return .zero
                }
                return incomeArray.reduce(0) { $0 + $1.sum }
            }
            
            var organizerCosts: Int {
                let costsArray = organizerItems.filter { $0.type == .cost }
                if costsArray.isEmpty {
                    return .zero
                }
                return costsArray.reduce(0) { $0 + $1.sum }
            }
            
            var organizerIncome: Int {
                let incomeArray = organizerItems.filter { $0.type == .income }
                if incomeArray.isEmpty {
                    return .zero
                }
                return incomeArray.reduce(0) { $0 + $1.sum }
            }
            
            let totalCost = memberCosts + organizerCosts
            let totalIncome = memberIncome + organizerIncome
            let resultIncome = self.income
            var percent: Int {
                if totalIncome >= .zero {
                    return .zero
                }
                
                return Int(resultIncome / Double(totalIncome)) * 100
            }
            
            let memberNote = HomeView.FinalNodeItem(
                title: "Учасник",
                costsText: "Сумма трат",
                costsValue: memberCosts,
                incomeText: "Сумма заработка",
                incomeValue: memberIncome,
                order: 0
            )
            let organizerNote = HomeView.FinalNodeItem(
                title: "Организатор",
                costsText: "Сумма трат",
                costsValue: organizerCosts,
                incomeText: "Сумма заработка",
                incomeValue: organizerIncome,
                order: 1
            )
            let resultNote = HomeView.FinalNodeItem(
                title: "Итог",
                costsText: "Итог трат",
                costsValue: totalCost,
                incomeText: "Итог заработка",
                incomeValue: totalIncome,
                order: 2
            )
            let incomeNote = HomeView.FinalNodeItem(
                title: "Моя Прибыль",
                costsText: "%",
                costsValue: percent,
                incomeText: "Прибыль",
                incomeValue: Int(resultIncome),
                order: 3
            )
            let section = HomeView.FinalNodeSection(nodes: [
                memberNote, organizerNote, resultNote, incomeNote
            ])
            
            DispatchQueue.main.async {
                DefaultsService.saveFinalNote(section: section)
                self.deleteNote()
            }
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
        var canEditTopField = false
    }
    
    struct FinalNodeSection: Codable, Identifiable {
        var id = UUID()
        var date = Date()
        var nodes: [FinalNodeItem]
    }
    
    struct FinalNodeItem: Codable, Identifiable {
        var id = UUID()
        var title: String
        var costsText: String
        var costsValue: Int
        var incomeText: String
        var incomeValue: Int
        var order: Int
    }
}
