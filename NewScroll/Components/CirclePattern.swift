//
//  CirclePattern.swift
//  NewScroll
//
//  Created by Astemir Eleev on 01.07.2023.
//

import SwiftUI

struct CirclePattern: View {
    @State private var iterations: CGFloat = 20.0
    @State private var color: Color = .black
    
    private let date = Date()
    
    var body: some View {
        List {
            TimelineView(.animation) {
                let time = date.timeIntervalSince1970 -  $0.date.timeIntervalSince1970
                
                Rectangle()
                    .aspectRatio(1, contentMode: .fit)
                    .colorEffect(ShaderLibrary.circlePattern(
                        .boundingRect,
                        .float(time),
                        .color(color),
                        .float(iterations)
                    ))
            }
                    .clipShape(RoundedRectangle(cornerRadius: 24))
            Section("Iterations") {
                Slider(value: $iterations, in: 5...100)
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

#Preview("Circle Pattern") {
    CirclePattern()
}
