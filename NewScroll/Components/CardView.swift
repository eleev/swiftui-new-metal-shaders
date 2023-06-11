//
//  CardView.swift
//  NewScroll
//
//  Created by Astemir Eleev on 08/06/2023.
//

import SwiftUI

struct CardView: View {
    @Binding var card: Card
    
    var body: some View {
        RoundedRectangle(cornerRadius: 24)
            .fill(.ultraThinMaterial)
            .overlay(
                alignment: .top,
                content: { MainCard(card: $card) }
            )
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .modifier(OutlineModifier(cornerRadius: 24))
            .padding(.bottom, 32)
            .overlay(
                alignment: .bottom,
                content: { BottomCard(card: $card) }
            )
            .shadowUniversal(radius: 5, y: -10)
    }
}

#Preview {
    CardView(card: .constant(Model().cards[0]))
        .preferredColorScheme(.dark)
        .previewDisplayName("CardView")
}
