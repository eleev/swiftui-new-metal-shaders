//
//  OversettableStoreScrollView.swift
//  NewScroll
//
//  Created by Astemir Eleev on 13.06.2023.
//

import SwiftUI

struct OversettableStoreScrollView: View {
    @Bindable var model: Model
    
    @State var position: CGPoint = .zero
    let startDate = Date()
    
    private func shader(offset: CGFloat) -> Shader {
        Shader(
            function: .init(library: .default, name: "wave2d"),
            arguments: [.float(offset)]
        )
    }
    
    var body: some View {
        VStack {
            scroller(count: 15)
            scroller(count: 13)
            scroller(count: 17)
        }
    }
    
    private func scroller(count: Int) -> some View {
        OversettableScrollView(
            axes: .horizontal,
            showsIndicator: false
        ) { point in
            self.position = point
        } content: {
            LazyHStack {
                ForEach(Array(zip(model.cards.indices, model.cards)), id: \.1) {
                    index, card in
                    LinearGradient(
                        colors: [
                            .red, card.color, card.color, .blue
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .overlay(Material.thin)
                    .overlay(content(card))
                    .modifier(CellModifier(containerRelativeFrameCount: count))
                    /*
                     .visualEffect { effect, proxy in effect
                     .offset(x: -min(0, proxy.frame(in: .scrollView).minX))
                     }
                     */
                    .modifier(CellScrollTransitionModifier(
                        i: index,
                        position: position)
                    )
                    .padding(.vertical)
                }
            }
        }
    }
    
    private func content(_ card: Card) -> some View {
        TimelineView(.animation) { context in
            RoundedRectangle(cornerRadius: 30)
                .stroke(.black, lineWidth: 3)
                .colorEffect(
                    ShaderLibrary.default.circleMesh(.boundingRect, .float(context.date.timeIntervalSince1970 - startDate.timeIntervalSince1970))
                )
                .overlay {
                    Text(card.title)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .fontDesign(.rounded)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(LinearGradient(colors: [.yellow, .blue], startPoint: .leading, endPoint: .trailing)
                        )
                        .shadow(radius: 10)
                        .distortionEffect(shader(offset: context.date.timeIntervalSince1970 - startDate.timeIntervalSince1970), maxSampleOffset: CGSize(width: 100, height: 100))
                }
        }
    }
    
    struct CellModifier: ViewModifier {
        var containerRelativeFrameCount: Int
        
        func body(content: Content) -> some View {
            content
                .frame(height: 220)
                .cornerRadius(30)
                .modifier(OutlineModifier(cornerRadius: 30))
                .shadow(color: .white.opacity(0.2), radius: 10)
                .padding()
                .containerRelativeFrame(
                    .horizontal,
                    count: containerRelativeFrameCount,
                    span: 10,
                    spacing: 0
                )
                .scrollTargetLayout()
                .scrollClipDisabled()
                .scrollBounceBehavior(.basedOnSize, axes: .horizontal)
        }
    }
    
    struct CellScrollTransitionModifier: ViewModifier {
        var i: Int
        var position: CGPoint
        
        func body(content: Content) -> some View {
            content
                .scrollTransition(
                    topLeading: .interactive,
                    bottomTrailing: .interactive,
                    axis: .horizontal
                ) { view, phase in
                    view
                        .blur(radius: phase.value * 1)
                        .opacity(phase.value > 0 ? 0.8: 1.0)
                        .scaleEffect(phase.value > 0.5 ? 0.8 : 1.0)
                        .rotationEffect(.degrees(i % 2 == 0 ? phase.value * CGFloat(5) : -phase.value * CGFloat(5)))
                        .offset(
                            x: phase.value > 0.8 ? -position.x - (CGFloat(i) * 200) : 0
                        )
                    
                }
        }
    }
}

#Preview {
    OversettableStoreScrollView(model: Model())
}
