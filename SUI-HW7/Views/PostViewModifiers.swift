//
//  PostViewModifiers.swift
//  SUI-HW7
//
//  Created by Dim on 08.07.2025.
//

import SwiftUI

extension View {
    func priceStyle() -> some View {
        self.modifier(PriceButtonStyle())
    }
}

struct PriceButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(.green)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
