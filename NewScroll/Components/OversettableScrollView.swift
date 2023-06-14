//
//  OversettableScrollView.swift
//  NewScroll
//
//  Created by Astemir Eleev on 13.06.2023.
//

import SwiftUI

struct OversettableScrollView<T: View>: View {
    let axes: Axis.Set
    let showsIndicator: Bool
    let onOffsetChanged: (CGPoint) -> Void
    let content: T
    
    init(
        axes: Axis.Set = .vertical,
        showsIndicator: Bool = true,
        onOffsetChanged: @escaping (CGPoint) -> Void = { _ in },
        @ViewBuilder content: () -> T
    ) {
        self.axes = axes
        self.showsIndicator = showsIndicator
        self.onOffsetChanged = onOffsetChanged
        self.content = content()
    }
    
    var body: some View {
        ScrollView(axes, showsIndicators: showsIndicator) {
            HStack {
                GeometryReader { proxy in
                    Color.clear.preference(
                        key: OversettablePreferenceKey.self,
                        value: proxy.frame(in: .named("ScrollViewOrigin")).origin
                    )
                }
                .frame(width: 0, height: 0)
                content
            }
            .scrollTargetLayout()
            .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
            .scrollBounceBehavior(.always)
            .coordinateSpace(name: "ScrollViewOrigin")
            .onPreferenceChange (OversettablePreferenceKey.self, perform: onOffsetChanged)
        }
    }
}

struct OversettablePreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint ) { /* Empty */ }
}
