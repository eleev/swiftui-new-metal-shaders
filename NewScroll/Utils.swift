//
//  Utils.swift
//  NewScroll
//
//  Created by Astemir Eleev on 08/06/2023.
//

import SwiftUI

struct BackgroundStyleView: View {
    var body: some View {
        LinearGradient(
            colors: [
                .purple,
                Color(uiColor: .systemBackground),
                .pink
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .opacity(0.25)
        .ignoresSafeArea()
    }
}

struct OutlineOverlay: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    var cornerRadius: CGFloat = 20
    
    func body(content: Content) -> some View {
        content.overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(
                    .linearGradient(
                        colors: [
                            .white.opacity(colorScheme == .dark ? 0.6 : 0.3),
                            .black.opacity(colorScheme == .dark ? 0.3 : 0.1)
                        ],
                        startPoint: .top,
                        endPoint: .bottom)
                )
                .blendMode(.overlay)
        )
    }
}

struct OutlineModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    var cornerRadius: CGFloat = 24
    
    func body(content: Content) -> some View {
        content.overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(
                    .linearGradient(
                        colors: [
                            .white.opacity(colorScheme == .dark ? 0.3 : 0.6),
                            .black.opacity(0.1)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing)
                )
        )
    }
}

struct OutlineVerticalModifier: ViewModifier {
    var cornerRadius: CGFloat = 20
    
    func body(content: Content) -> some View {
        content.overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(
                    .linearGradient(
                        colors: [.black.opacity(0.2), .white.opacity(0.6)],
                        startPoint: .top,
                        endPoint: .bottom)
                )
                .blendMode(.overlay)
        )
    }
}

struct BackgroundColor: ViewModifier {
    var opacity: Double = 0.6
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .overlay(
                Color("Background")
                    .opacity(colorScheme == .dark ? opacity : 0)
                    .blendMode(.overlay)
                    .allowsHitTesting(false)
            )
    }
}

struct BackgroundStyle: ViewModifier {
    
    // MARK: - Properties
    
    var cornerRadius: CGFloat = 20
    var opacity: Double = 0.6
    var shadowRadius: CGFloat = 20
    
    // MARK: - View Modifier Body
    
    func body(content: Content) -> some View {
        content
            .backgroundColor(opacity: opacity)
            .cornerRadius(cornerRadius)
            .shadowUniversal(
                radius: shadowRadius,
                x: 0,
                y: 10,
                opacity: 0.3
            )
            .modifier(OutlineOverlay(cornerRadius: cornerRadius))
    }
}

extension View {
    func backgroundColor(opacity: Double = 0.6) -> some View {
        modifier(BackgroundColor(opacity: opacity))
    }
}

extension View {
    func backgroundStyle(cornerRadius: CGFloat = 20, opacity: Double = 0.6) -> some View {
        modifier(BackgroundStyle(cornerRadius: cornerRadius, opacity: opacity))
    }
}

struct ShadowModifier: ViewModifier {
    
    // MARK: - Properties
    
    var radius: CGFloat = 10
    var x: CGFloat = 0
    var y: CGFloat = 0
    var opacity: CGFloat = 0.3
    var shadowName: String = "Shadow"
    
    // MARK: - Body Content
    
    func body(content: Content) -> some View {
        content
            .shadow(
                color: Color(shadowName).opacity(opacity),
                radius: radius, x: x, y: y
            )
    }
}

extension View {
    func shadowUniversal(
        radius: CGFloat = 10,
        x: CGFloat = 0,
        y: CGFloat = 0,
        opacity: CGFloat = 0.3,
        shadowName: String = "Shadow"
    ) -> some View {
        self.modifier(
            ShadowModifier(
                radius: radius,
                x: x, y: y,
                opacity: opacity,
                shadowName: shadowName
            )
        )
    }
}
