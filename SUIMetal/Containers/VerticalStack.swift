//
//  VerticalStack.swift
//  NewScroll
//
//  Created by Astemir Eleev on 09/06/2023.
//

import SwiftUI

struct VerticalStack: View  {
    
    // MARK: - Properties
    
    @Bindable var model: Model
    
    // MARK: - View Body
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 64, content: items)
            .padding(24)
            .scrollTargetLayout()
        }
        // NOTE: these new scroll target and bounce behavior are quite powerful in conjunction with the various kinds of scrolling layout that can be composed
        .scrollTargetBehavior(.viewAligned)
        .scrollBounceBehavior(.basedOnSize)
        .background(BackgroundStyleView())
    }
    
    // MARK: - Items
    
    private func items() -> some View {
        ForEach($model.cards) { card in
            CardView(
                card: card
            )
            // NOTE: new container relative frames are very quite useful and eliminate the need usage of `GeometryReader` in some places
            .containerRelativeFrame(
                .vertical,
                count: 16,
                span: 7,
                spacing: 16
            )
            .visualEffect { effect, proxy in
                effect
                    .offset(y: -min(0, proxy.frame(in: .scrollView).minY))
                    .blur(radius: -min(0, proxy.frame(in: .scrollView).minY / 100))
            }
            .scrollTransition { content, phase in
                // NOTE: play around with the visual effect modifiers to compose a desired scroll transition effect
                content
                    .rotation3DEffect(.degrees(phase.isIdentity ? 0 : 60), axis: (-1, 1, 0))
                    .rotationEffect(.degrees(phase.isIdentity ? 0 : -30))
                    .offset(x: phase.isIdentity ? 0 : -200)
                    .blur(radius: phase.isIdentity ? 0 : 5)
                    .scaleEffect(phase.isIdentity ? 1 : 0.7)
                    .opacity(phase.isIdentity ? 1 : 0)
            }
        }
    }
}
