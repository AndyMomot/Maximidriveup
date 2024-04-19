//
//  CustomTabBarView.swift
//  Maximidriveup
//
//  Created by Andrii Momot on 17.04.2024.
//

import SwiftUI

struct CustomTabBarView: View {
    @Binding var selectedItem: Int
    private let bounds = UIScreen.main.bounds
    
    
    private let items: [MainTabBarView.Item] = [
        .init(backgroundImage: Asset.tabBar0.name),
        .init(backgroundImage: Asset.tabBar1.name),
        .init(backgroundImage: Asset.tabBar2.name),
        .init(backgroundImage: Asset.tabBar3.name),
    ]
    
    var body: some View {
        ZStack {
            Image(items[selectedItem].backgroundImage)
                .resizable()
                .scaledToFill()
                .frame(width: bounds.width,
                       height: bounds.height * 0.15)
            
            HStack(spacing: .zero) {
                Spacer()
                ForEach(0..<4) { index in
                    Button {
                        selectedItem = index
                    } label: {
                        Rectangle()
                            .frame(
                                width: bounds.width * 0.2,
                                height: bounds.height * 0.08
                            )
                            .foregroundColor(.clear)
//                            .border(Color.red)
                            .padding(.top)
                    }
                    Spacer()
                }
            }
        }
    }
}

struct CustomTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    .white,
                    Colors.liteGray.swiftUIColor
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            
            VStack {
                Spacer()
                
                CustomTabBarView(selectedItem: .constant(0))
            }
            .ignoresSafeArea(edges: .bottom)
        .previewLayout(.sizeThatFits)
        }
    }
}
