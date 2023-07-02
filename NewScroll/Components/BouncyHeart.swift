//
//  BouncyHeart.swift
//  NewScroll
//
//  Created by Astemir Eleev on 26.06.2023.
//

import SwiftUI

struct BouncyHeart: View {
    @State private var size: CGFloat = 0.0
    @State private var color: Color = .white
    @State private var bkgColor: Color = .white
    
    private let date = Date()
    
    var body: some View {
        List {
            TimelineView(.animation) {
                let time = date.timeIntervalSince1970 -  $0.date.timeIntervalSince1970
                
                Rectangle()
                    .aspectRatio(1, contentMode: .fit)
                    .colorEffect(ShaderLibrary.heart(
                        .boundingRect,
                        .float(time),
                        .color(color),
                        .color(bkgColor),
                        .float(-size)
                    ))
                    .clipShape(RoundedRectangle(cornerRadius: 24))
            }
            Section("size") {
                HStack {
                    Slider(value: $size, in: -0.3...0.3)
                }
            }
            Section("Color") {
                ColorPicker(
                    "Heart",
                    selection: $color,
                    supportsOpacity: false
                )
                ColorPicker(
                    "Background",
                    selection: $bkgColor,
                    supportsOpacity: false
                )
            }
        }
    }
}

#Preview("Bouncy Heart") {
    BouncyHeart()
}
