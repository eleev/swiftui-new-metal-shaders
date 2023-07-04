//
//  Lightspeed.swift
//  NewScroll
//
//  Created by Astemir Eleev on 03.07.2023.
//

import SwiftUI

struct Lightspeed: View {
    @State private var rays: CGFloat = 150.0
    @State private var fx: CGFloat = 80.0
    @State private var fy: CGFloat = 45.0
    
    private let date = Date()
    
    var body: some View {
        List {
            TimelineView(.animation) {
                let time = date.timeIntervalSince1970 -  $0.date.timeIntervalSince1970
                
                Rectangle()
                    .aspectRatio(1, contentMode: .fit)
                    .colorEffect(ShaderLibrary.lightspeed(
                        .boundingRect,
                        .float(time),
                        .float(rays),
                        .float(fx),
                        .float(fy)
                    ))
            }
            .clipShape(RoundedRectangle(cornerRadius: 24))
            
            Section("Rays") {
                Slider(value: $rays, in: 10...1000)
            }
            Section("Fx") {
                Slider(value: $fx, in: 10...100)
            }
            Section("Fy") {
                Slider(value: $fy, in: 10...100)
            }
        }
    }
}

#Preview("Lightspeed") {
    Lightspeed()
}
