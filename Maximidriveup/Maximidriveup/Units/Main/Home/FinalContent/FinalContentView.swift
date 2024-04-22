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
    var onIncomeChanged: (Double) -> Void
    
    @State private var percentText = ""
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 10) {
                IncomeCostCell(
                    model: createMemberModel(),
                    text: .constant(""))
                IncomeCostCell(
                    model: createOrganizerModel(),
                    text: .constant(""))
                IncomeCostCell(
                    model: createResultModel(),
                    text: .constant(""))
                IncomeCostCell(
                    model: createIncomeModel(),
                    text: $percentText)
            }
        }
        .onChange(of: percentText) { _ in
            onIncomeChanged(getIncome())
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
        let percent = Double(percentText) ?? .zero
        
        return HomeView.FinalIncomeCostModel(
            title: "Моя Прибыль",
            topFieldName: "%",
            bottomFieldName: "Прибыль",
            topFieldValue: Double(percent),
            bottomFieldValue: getIncome(),
            showTopFieldDollarMark: false,
            canEditTopField: true
        )
    }
    
    func getIncome() -> Double {
        let result = createResultModel()
        let percent = Double(percentText) ?? .zero
        return (result.bottomFieldValue / 100) * percent
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
        ) { _ in }
    }
}
