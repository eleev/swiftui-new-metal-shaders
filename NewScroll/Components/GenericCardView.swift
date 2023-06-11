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

// WIP: playing around with difference shaders
struct TimelineImageView: View {
    @Binding var card: Card
    private let startDate = Date()
    
    private func shader(offset: CGFloat) -> Shader {
        Shader(function: .init(library: .default, name: "wave"), arguments: [.float(offset)])
    }
    private func shaderWave2d(offset: CGFloat) -> Shader {
        Shader(function: .init(library: .default, name: "wave2d"), arguments: [.float(offset)])
    }
    private func shader(
        offset: CGFloat,
        angle: CGFloat,
        width: CGFloat,
        height: CGFloat
    ) -> Shader {
        Shader(
            function: .init(library: .default, name: "kaleidoscope"), arguments: [
                .float2(width, height),
                .float2(offset, offset),
                .float(22),
                .float(angle),
                .float(1.0),
        ])
    }
    
    var body: some View {
        TimelineView(.animation) { context in
            ZStack(alignment: .top) {
                GeometryReader { proxy in
                    let size = proxy.frame(in: .local)
                    Image(card.img)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .opacity(0.5)
                        .distortionEffect(
                            shaderWave2d(
                                offset: context.date.timeIntervalSince1970 - startDate.timeIntervalSince1970
                            ),
                            maxSampleOffset: CGSize(width: 100, height: 100)
                        )
                }
                
                Text(card.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .padding()
                    .distortionEffect(
                        shader(
                            offset: context.date.timeIntervalSince1970 - startDate.timeIntervalSince1970
                        ),
                        maxSampleOffset: CGSize(width: 100, height: 100)
                    )
                    .shadowUniversal(radius: 10, y: 0)
            }
        }
    }
}
