//
//  FractalPattern.swift
//  NewScroll
//
//  Created by Astemir Eleev on 22.06.2023.
//

import SwiftUI

struct FractalPattern: View {
    @State private var iterations: CGFloat = 4.0
    @State private var repeatness: CGFloat = 1.5
    @State private var phase: CGFloat = 8.0
    
    let date = Date()
    
    var body: some View {
        List {
            TimelineView(.animation) {
                let time = date.timeIntervalSince1970 -  $0.date.timeIntervalSince1970
                
                Rectangle()
                    .aspectRatio(1, contentMode: .fit)
                    .colorEffect(ShaderLibrary.fractalPattern(
                        .boundingRect,
                        .float(-time),
                        .float(iterations),
                        .float(repeatness),
                        .float(phase)
                    ))
                    .clipShape(RoundedRectangle(cornerRadius: 24))
            }
            
            Section("Iterations") {
                Slider(value: $iterations, in: 1...8)
            }
            Section("Repeatness") {
                Slider(value: $repeatness, in: 1...5)
            }
            Section("Phase") {
                Slider(value: $phase, in: 1...50)
            }
        }
    }
}

#Preview {
    FractalPattern()
}

