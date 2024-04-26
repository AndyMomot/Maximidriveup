//
//  CurrencyPicker.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 26.04.2024.
//

import SwiftUI

struct CurrencyPicker: View {
    var onSelect: (DefaultsService.Currency) -> Void
    
    init(onSelect: @escaping (DefaultsService.Currency) -> Void) {
        self.onSelect = onSelect
    }
    
    private var currencyArray = DefaultsService.Currency.allCases
    @State private var currentCurrency = DefaultsService.currency.rawValue
    @State private var showMore = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Валюта")
                    .foregroundColor(.black)
                    .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 14))
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 2)
                    .background(Color.white)
                    .cornerRadius(10)
                    .frame(height: 44)
                
                HStack {
                    Text(currentCurrency)
                        .foregroundColor(.black)
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 14))
                    
                    Spacer()
                    
                    Button {
                        withAnimation {
                            showMore.toggle()
                        }
                    } label: {
                        if showMore {
                            Asset.backButton.swiftUIImage
                                .rotationEffect(.degrees(90))
                        } else {
                            Asset.backButton.swiftUIImage
                                .rotationEffect(.degrees(-90))
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            if showMore {
                Divider()
                
                ForEach(currencyArray, id: \.rawValue) { currency in
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 2)
                            .background(Color.white)
                            .cornerRadius(10)
                            .frame(height: 44)
                        
                        HStack {
                            Text(currency.rawValue)
                                .foregroundColor(.black.opacity(0.9))
                                .font(Fonts.SFProDisplay.light.swiftUIFont(size: 12))
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    .onTapGesture {
                        withAnimation {
                            currentCurrency = currency.rawValue
                            showMore.toggle()
                        }
                        
                        onSelect(currency)
                    }
                }
            }
        }
    }
}

struct CurrencyPicker_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyPicker { _ in }
    }
}
