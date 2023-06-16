//
//  OversettableCardStack.swift
//  NewScroll
//
//  Created by Astemir Eleev on 15.06.2023.
//

import SwiftUI

struct OversettableCardStack: View {
    @State var position: CGPoint = .zero
    
    var body: some View {
        OversettableScrollView(
            axes: .horizontal,
            showsIndicator: false
        ) { point in
            self.position = point
        } content: {
            LazyHStack {
                ForEach(0..<20) {
                    i in
                    ApollonianGasketCard()
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(.primary, lineWidth: 4)
                                .blur(radius: 4)
                        )
                        .modifier(RelativeFrameModifier())
                        .cornerRadius(30)
                        .shadow(
                            color: .primary.opacity(0.5),
                            radius: 12
                        )
                        .padding()
                        .scrollTargetLayout()
                        .modifier(OversettableStackVFX(i: i))
                }
            }
        }
        .scrollTargetBehavior(.paging)
        .scrollIndicators(.hidden)
        .scrollClipDisabled()
    }
    
    struct RelativeFrameModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
                .containerRelativeFrame(
                    .vertical,
                    count: 4,
                    span: 3,
                    spacing: 0
                )
                .containerRelativeFrame(
                    .horizontal,
                    count: 10,
                    span: 9,
                    spacing: 0
                )
        }
    }
    
    struct OversettableStackVFX: ViewModifier {
        var i: Int
        func body(content: Content) -> some View {
            content
                .visualEffect { effect, proxy in
                    effect
                        .blur(radius: progress(proxy) *
                    4 )
                        .rotationEffect( .init(degrees: progress(proxy) * (i % 2 == 0 ? -7 : 7))
                        )
                        .scaleEffect (scale(proxy))
                        .offset(x: minX(proxy) < 0 ? 0 : minX(proxy))
                }
        }
        
        private func scale(_ proxy: GeometryProxy) -> CGFloat {
            let progress = progress (proxy) * 0.05
            let scale = 1 - progress
            return min(max(scale, 0.95), 1)
        }
        
        private func progress(_ proxy: GeometryProxy) -> CGFloat {
            let progress = minX(proxy) / proxy.size.width
            return min(progress, 1)
        }
        
        private func minX(_ proxy: GeometryProxy) -> CGFloat {
            return proxy.bounds(of: .scrollView)?.minX ?? 0
        }
    }
}

#Preview {
    OversettableCardStack()
}

