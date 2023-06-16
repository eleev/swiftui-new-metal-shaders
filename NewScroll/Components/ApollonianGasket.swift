//
//  ApollonianGasketCard.swift
//  NewScroll
//
//  Created by Astemir Eleev on 15.06.2023.
//

import SwiftUI

struct ApollonianGasketCard: View {
    @State private var z: CGFloat = 4
    let start = Date()
    
    var body: some View {
        VStack {
            TimelineView(.animation) { context in
                Rectangle()
                    .apollonianGasket(
                        seconds: context.date.timeIntervalSince1970 - self.start.timeIntervalSince1970,
                        z: z
                    )
                    .overlay(alignment: .bottomLeading) { infoView }
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(alignment: .bottomTrailing) {
                        Stepper(
                            "",
                            value: $z,
                            in: 1...10,
                            step: 1
                        )
                        .fixedSize()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Material.ultraThinMaterial)
                                .padding(-6)
                        )
                        .padding(10)
                    }
            }
        }
        .padding()
    }
    
    private var infoView: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text("Apollonian Gasket\nShader CC0 by mrange\nDirect port to Metal [WIP]")
                .font(.caption.bold())
                .fontDesign(.rounded)
                .foregroundStyle(.black.gradient)
                .background(background)
        }
        .padding(20)
    }
    
    private var background: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Material.ultraThinMaterial)
            .overlay(alignment: .topTrailing) {
                Image(systemName: "info.circle")
                    .foregroundStyle(.yellow)
                    .padding(6)
            }
            .padding(-16)
    }
}

extension View {
    func apollonianGasket(seconds: Double, z: CGFloat) -> some View {
        self.colorEffect(
            ShaderLibrary.default.apollonianGasket(
                .boundingRect,
                .float(seconds),
                .float(z)
            )
        )
    }
}

#Preview {
    ApollonianGasketCard()
}
