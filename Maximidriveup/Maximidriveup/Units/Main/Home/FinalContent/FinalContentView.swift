//
//  FinalContentView.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 19.04.2024.
//

import SwiftUI

struct FinalContentView: View {
    var memberItems: [HomeView.IncomeCostModel]
    var organizerItems: [HomeView.IncomeCostModel]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 10) {
                IncomeCostCell(model: createMemberModel())
                IncomeCostCell(model: createOrganizerModel())
                IncomeCostCell(model: createResultModel())
                IncomeCostCell(model: createIncomeModel())
            }
        }
    }
}

private extension FinalContentView {
    func createMemberModel() -> HomeView.FinalIncomeCostModel {
        var costs: Int {
            let costsArray = memberItems.filter { $0.type == .cost }
            if costsArray.isEmpty {
                return .zero
            }
            return costsArray.reduce(0) { $0 + $1.sum }
        }
        
        var income: Int {
            let incomeArray = memberItems.filter { $0.type == .income }
            if incomeArray.isEmpty {
                return .zero
            }
            return incomeArray.reduce(0) { $0 + $1.sum }
        }
        
        return HomeView.FinalIncomeCostModel(
            title: "Учасник",
            topFieldName: "Сумма трат",
            bottomFieldName: "Сумма заработка",
            topFieldValue: Double(costs),
            bottomFieldValue: Double(income))
    }
    
    func createOrganizerModel() -> HomeView.FinalIncomeCostModel {
        var costs: Int {
            let costsArray = organizerItems.filter { $0.type == .cost }
            if costsArray.isEmpty {
                return .zero
            }
            return costsArray.reduce(0) { $0 + $1.sum }
        }
        
        var income: Int {
            let incomeArray = organizerItems.filter { $0.type == .income }
            if incomeArray.isEmpty {
                return .zero
            }
            return incomeArray.reduce(0) { $0 + $1.sum }
        }
        
        return HomeView.FinalIncomeCostModel(
            title: "Организатор",
            topFieldName: "Сумма трат",
            bottomFieldName: "Сумма заработка",
            topFieldValue: Double(costs),
            bottomFieldValue: Double(income))
    }
    
    func createResultModel() -> HomeView.FinalIncomeCostModel {
        let member = createMemberModel()
        let organizer = createOrganizerModel()
        
        let costs = Double(member.topFieldValue + organizer.topFieldValue)
        let income = Double(member.bottomFieldValue + organizer.bottomFieldValue)
        
        return HomeView.FinalIncomeCostModel(
            title: "Итог",
            topFieldName: "Итог трат",
            bottomFieldName: "Итог заработка",
            topFieldValue: Double(costs),
            bottomFieldValue: Double(income))
    }
    
    func createIncomeModel() -> HomeView.FinalIncomeCostModel {
        let result = createResultModel()
        let income = result.bottomFieldValue - result.topFieldValue
        var percent: Double {
            if income > .zero {
                return (income / result.bottomFieldValue) * 100
            } else {
                return .zero
            }
        }
        
        return HomeView.FinalIncomeCostModel(
            title: "Моя Прибыль",
            topFieldName: "%",
            bottomFieldName: "Прибыль",
            topFieldValue: Double(percent),
            bottomFieldValue: income,
            showTopFieldDollarMark: false)
    }
    
}

struct FinalContentView_Previews: PreviewProvider {
    static var previews: some View {
        FinalContentView(
            memberItems: [
                .init(type: .income,
                      title: "Income 1",
                      sum: 500),
                .init(type: .cost,
                      title: "Cost 1",
                      sum: 250)
            ],
            organizerItems: [
                .init(type: .income,
                      title: "Income 2",
                      sum: 900),
                .init(type: .cost,
                      title: "Cost 2",
                      sum: 400)
            ]
        )
    }
}
