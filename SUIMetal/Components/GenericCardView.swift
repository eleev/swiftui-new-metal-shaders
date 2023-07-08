//
//  GenericCardView.swift
//  NewScroll
//
//  Created by Astemir Eleev on 11/06/2023.
//

import SwiftUI

struct GenericCardView<V>: View where V: View {
    @Binding var card: Card
    var mainCard: V
    let cornerRadius: CGFloat = 24
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(.ultraThinMaterial)
            .overlay(
                alignment: .top,
                content: { mainCard }
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .modifier(OutlineModifier(cornerRadius: cornerRadius))
            .padding(.bottom, 32)
            .overlay(
                alignment: .bottom,
                content: { BottomCard(card: $card) }
            )
            .shadowUniversal(radius: 5, y: -10)
    }
}

#Preview {
    let mock = Binding.constant(Model().cards[0])
    return GenericCardView(
        card: mock,
        mainCard: TimelineImageView(card: mock)
    )
    .preferredColorScheme(.dark)
    .previewDisplayName("CardView")
}
