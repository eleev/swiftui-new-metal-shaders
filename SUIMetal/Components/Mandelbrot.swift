//
//  Mandelbrot.swift
//  NewScroll
//
//  Created by Astemir Eleev on 23.06.2023.
//

import SwiftUI

struct Mandelbrot: View {
    @State private var iterations: CGFloat = 2.0
    @State private var color: Color = .black
    
    private let date = Date()
    private let defaultIterations = 2.0
    
    var body: some View {
        List {
            TimelineView(.animation) {
                let time = date.timeIntervalSince1970 -  $0.date.timeIntervalSince1970
                
                Rectangle()
                    .aspectRatio(1, contentMode: .fit)
                    .colorEffect(ShaderLibrary.mandelbrot(
                        .boundingRect,
                        .float(-time),
                        .color(color),
                        .float(iterations)
                    ))
                    .clipShape(RoundedRectangle(cornerRadius: 24))
            }
            Section("Iterations") {
                HStack {
                    Slider(value: $iterations, in: 1.5...4)
                    Button(action: { iterations = defaultIterations }) {
                        Image(systemName: "arrow.counterclockwise")
                    }
                    .buttonBorderShape(.capsule)
                    .buttonStyle(.bordered)
                    .disabled(iterations == defaultIterations)
                }
            }
            Section {
                ColorPicker(
                    "Base Color",
                    selection: $color,
                    supportsOpacity: false
                )
            }
        }
    }
}

#Preview {
    Mandelbrot()
}
