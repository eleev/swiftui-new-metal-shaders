//
//  Fireworks.swift
//  NewScroll
//
//  Created by Astemir Eleev on 03.07.2023.
//

import SwiftUI

struct Fireworks: View {
    @State private var explosionCount: CGFloat = 4
    @State private var spartksPerExplosition: CGFloat = 128
    @State private var explosionDuration: CGFloat = 20
    @State private var timelineDirection: CGFloat = -1
    private let date = Date()
    
    var body: some View {
        List {
            TimelineView(.animation) {
                let time = date.timeIntervalSince1970 -  $0.date.timeIntervalSince1970
                
                Rectangle()
                    .aspectRatio(1, contentMode: .fit)
                    .colorEffect(ShaderLibrary.fireworks(
                        .boundingRect,
                        .float(time * timelineDirection),
                        .float(explosionCount),
                        .float(spartksPerExplosition),
                        .float(explosionDuration)
                    ))
            }
            .clipShape(RoundedRectangle(cornerRadius: 24))
            
            Section("Explosion Count") {
                HStack {
                    Text("\(Int(explosionCount))")
                        .foregroundStyle(.gray)
                    Slider(
                        value: $explosionCount,
                        in: 1...20,
                        step: 1
                    )
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundStyle(.gray)
                        
                }
            }
            Section("Sparks Per Explosion") {
                HStack {
                    Text("\(Int(spartksPerExplosition))")
                        .foregroundStyle(.gray)
                    Slider(
                        value: $spartksPerExplosition,
                        in: 16...256,
                        step: 8
                    )
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundStyle(.gray)
                        
                }
            }
            Section("Explosion Duration") {
                HStack {
                    Text("\(Int(explosionDuration))")
                        .foregroundStyle(.gray)
                    Slider(
                        value: $explosionDuration,
                        in: 5...40,
                        step: 1
                    )
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundStyle(.gray)
                        
                }
            }
            Section("Timeline Direction") {
                HStack {
                    Button(action: {
                        timelineDirection = timelineDirection == -1 ? 1 : -1
                    }) {
                        Image(systemName: timelineDirection == -1 ? "forward" : "backward")
                    }
                        
                }
            }
        }
    }
}

#Preview("Fireworks") {
    Fireworks()
}
