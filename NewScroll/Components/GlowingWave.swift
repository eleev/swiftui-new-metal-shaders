//
//  GlowingWave.swift
//  NewScroll
//
//  Created by Astemir Eleev on 01.07.2023.
//

import SwiftUI

struct GlowingWave: View {
    @State private var thinness: CGFloat = 2.0
    @State private var scale: CGFloat = 3.5
    @State private var color: Color = .mint
    
    private let date = Date()
    
    var body: some View {
        List {
            TimelineView(.animation) {
                let time = date.timeIntervalSince1970 -  $0.date.timeIntervalSince1970
                
                Rectangle()
                    .aspectRatio(1, contentMode: .fit)
                    .colorEffect(ShaderLibrary.waveg(
                        .boundingRect,
                        .float(time),
                        .color(color),
                        .float(thinness),
                        .float(0),
                        .float(scale)
                    ))
            }
                    .clipShape(RoundedRectangle(cornerRadius: 24))
            Section("Thinness") {
                Slider(value: $thinness, in: 0.5...10)
            }
            Section("Scale") {
                Slider(value: $scale, in: 1...10)
            }
            Section("Color") {
                ColorPicker(
                    "Wave",
                    selection: $color,
                    supportsOpacity: false
                )
            }
        }
    }
}

#Preview("Glowing Wave") {
    GlowingWave()
}

