//
//  FieldCell.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 18.04.2024.
//

import SwiftUI

struct FieldCell: View {
    var item: HomeView.IncomeCostModel
    var onDelete: () -> Void
    var onSumChanged: (Int) -> Void
    
    @State private var sliderValue: Double = 0.0
    @State private var previousValue: Double = 0
    @State private var timer: Timer?
    
    var body: some View {
        ZStack {
            Color.black
            
            HStack {
                VStack(spacing: 8) {
                    HStack {
                        Text(item.title)
                            .foregroundColor(.white)
                            .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 14))
                        
                        Spacer(minLength: .zero)
                        
                        HStack {
                            ZStack {
                                Color.white
                                    .frame(
                                        width: 100,
                                        height: 30)
                                    .cornerRadius(8)
                                
                                Text("\(Int(sliderValue))")
                                    .foregroundColor(.black)
                                    .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 14))
                            }
                            
                            Text(DefaultsService.currency.icon)
                                .foregroundColor(.white)
                                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 24))
                        }
                    }
                    
                    StepSlider(value: $sliderValue)
                }
                .frame(maxHeight: 53)
                
                Spacer(minLength: 10)
                
                Button {
                    onDelete()
                } label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(3)
                            .frame(width: 16)
                        
                        Asset.tresh.swiftUIImage
                    }
                }
            }
        }
        .onAppear {
            sliderValue = Double(item.sum)
        }
        .onChange(of: sliderValue) { newValue in
            if let timer = timer {
                timer.invalidate()
            }
            
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                // Вызываем функцию через секунду
                let intSum = Int(newValue)
                onSumChanged(intSum)
            }
            
            // Запоминаем предыдущее значение
            previousValue = newValue
        }
    }
}

struct FieldCell_Previews: PreviewProvider {
    static var previews: some View {
        FieldCell(
            item: .init(
                type: .cost,
                title: "Взнос на участие"
            ), onDelete: {}, onSumChanged: { _ in}
        )
        .previewLayout(.sizeThatFits)
    }
}

struct StepSlider: View {
    @Binding var value: Double
    let step: Double = 50
    let range: ClosedRange = 0...10_000.0
    
    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
                    .frame(height: 2)
                
                Slider(value: Binding<Double>(
                        get: { self.value },
                        set: { self.value = round($0 / self.step) * self.step }
                ), in: range, step: step)
                .accentColor(Colors.yellow.swiftUIColor)
            }
        }
    }
}
