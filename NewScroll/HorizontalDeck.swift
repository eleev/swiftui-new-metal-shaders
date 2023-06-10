//
//  HorizontalDeck.swift
//  NewScroll
//
//  Created by Astemir Eleev on 09/06/2023.
//

import SwiftUI

struct HorizontalDeck: View {
    
    // MARK: - Properties
    
    @Bindable var model: Model
    
    // MARK: - View Body
    
    var body: some View {
        ScrollView(.horizontal){
            LazyHStack(spacing: 0, content: items)
            .scrollTargetLayout()
        }
        .scrollIndicators(.never)
        .scrollTargetBehavior(.paging)
    }
    
    // MARK: - Items
    
    private func items() -> some View {
        ForEach($model.cards) { card in
            CardView(card: card)
                .frame(maxWidth: .infinity, maxHeight:.infinity)
                .padding(.horizontal)
                .containerRelativeFrame(
                    .horizontal
                )
                .visualEffect { effect, proxy in
                    effect
                        .offset(x: -min(0, proxy.frame(in: .scrollView).minX))
                        .rotation3D(.degrees(-min(0, proxy.frame(in: .scrollView).minX / 50)), axis: (0, 1, 0))
                        .brightness(min(0, proxy.frame(in: .scrollView).minX / 1_000))
                }
        }
    }
}
