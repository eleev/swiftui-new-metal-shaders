//
//  Flame.swift
//  NewScroll
//
//  Created by Astemir Eleev on 07.07.2023.
//

import SwiftUI

struct Flame: View {
    @State private var bloom: CGFloat = 0.1
    @State private var verticalMotion: CGFloat = 0.01
    @State private var horizontalMotion: CGFloat = 0.035
    @State private var r: CGFloat = 0.0
    @State private var g: CGFloat = 0.0
    @State private var b: CGFloat = 0.0
    private let date = Date()
    
    var body: some View {
        List {
            TimelineView(.animation) {
                let time = date.timeIntervalSince1970 -  $0.date.timeIntervalSince1970
                
                Rectangle()
                    .aspectRatio(1, contentMode: .fit)
                    .colorEffect(ShaderLibrary.candleFlame(
                        .boundingRect,
                        .float(time),
                        .float(bloom),
                        .float2(horizontalMotion, verticalMotion),
                        .float3(r, g, b)
                    ))
            }
            .clipShape(RoundedRectangle(cornerRadius: 24))
            
            Section("Bloom") {
                HStack {
                    Slider(
                        value: $bloom,
                        in: 0...0.2
                    )
                }
            }
            Section("Motion") {
                VStack {
                    Slider(
                        value: $horizontalMotion,
                        in: 0...0.1
                    )
                    Slider(
                        value: $verticalMotion,
                        in: 0...0.1
                    )
                }
            }
            Section("Color") {
                Slider(
                    value: $r,
                    in: -0.1...0.1
                )
                Slider(
                    value: $g,
                    in: -0.1...0.1
                )
                Slider(
                    value: $b,
                    in: -1...0.1
                )
            }
        }
    }
}

#Preview("Flame") {
    Flame()
}
