//
//  ComplexWaveView.swift
//  NewScroll
//
//  Created by Astemir Eleev on 21.06.2023.
//

import SwiftUI

struct ComplexWaveView: View {
    @Bindable private var controller = ComplexWaveController()
    private let date = Date()

    private var rainbow: some View {
        Image(systemName: "rainbow")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .symbolRenderingMode(.multicolor)
            .symbolEffect(.variableColor.reversing)
    }
    
    var body: some View {
        List {
            TimelineView(.animation) { context in
                let time = context.date.timeIntervalSince1970 - date.timeIntervalSince1970

                VStack(spacing: -12) {
                    rainbow
                    rainbow
                        .rotationEffect(.degrees(180))
                        .opacity(0.2)
                        .blendMode(.overlay)
                        .blur(radius: 2)
                }
                .modifier(ComplexWaveModifierVFX(
                    controller: controller,
                    time: time
                ))
            }
            Section("Speed") {
                Slider(value: $controller.speed, in: 0...4)
            }
            Section("Frequency") {
                Slider(value: $controller.frequency, in: 1...40)
            }
            Section("Strength") {
                Slider(value: $controller.strength, in: 1...30)
            }
        }
    }
    
    @Observable
    private class ComplexWaveController {
        var speed: CGFloat = 0.3
        var frequency: CGFloat = 12
        var strength: CGFloat = 7
    }
    
    private struct ComplexWaveModifierVFX: ViewModifier {
        @Bindable var controller: ComplexWaveController
        var time: CGFloat
        
        func body(content: Content) -> some View {
             content
                .visualEffect { content, proxy in
                    content
                        .distortionEffect(
                            ShaderLibrary.complexWave(
                                .float(time),
                                .float(controller.speed),
                                .float(controller.frequency),
                                .float(controller.strength),
                                .float2(proxy.size)
                            ),
                            maxSampleOffset: .zero
                        )
                }
        }
    }
}

#Preview {
    ComplexWaveView()
}
