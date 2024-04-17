//
//  CustomSegmentControlView.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 17.04.2024.
//

import SwiftUI

struct CustomSegmentControlView: View {
    
    var items: [String]
    @Binding var selectedItem: Int
    
    var body: some View {
        HStack(spacing: 1) {
            ForEach(Array(items.enumerated()), id: \.element) { index, item in
                VStack(spacing: 4) {
                    Text(item)
                        .foregroundColor(.black)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 15))
                    
                    var color: Color {
                        if index == selectedItem {
                            return Colors.yellow.swiftUIColor
                        }
                        
                        return .clear
                    }
                    
                    Rectangle()
                        .frame(height: 3)
                        .foregroundColor(color)
                }
                .onTapGesture {
                    withAnimation(.easeIn(duration: 0.1)) {
                        selectedItem = index
                    }
                }
            }
        }
    }
}

struct CustomSegmentControlView_Previews: PreviewProvider {
    static var previews: some View {
        CustomSegmentControlView(items: [
            "Учасник", "Организатор", "Финал"
        ], selectedItem: .constant(0))
    }
}
