//
//  MainCard.swift
//  NewScroll
//
//  Created by Astemir Eleev on 11/06/2023.
//

import SwiftUI

struct MainCard: View {
    @Binding var card: Card
    private let startDate = Date()
    
    private func shader(offset: CGFloat) -> Shader {
        Shader(function: .init(library: .default, name: "wave"), arguments: [.float(offset)])
    }
    private func shader(
        offset: CGFloat,
        angle: CGFloat,
        width: CGFloat,
        height: CGFloat
    ) -> Shader {
        Shader(
            function: .init(library: .default, name: "kaleidoscope"), arguments: [
                .float2(width, height),
                .float2(offset, offset),
                .float(22),
                .float(angle),
                .float(1.0),
        ])
    }
    
    var body: some View {
        TimelineView(.animation) { context in
            ZStack(alignment: .top) {
                GeometryReader { proxy in
                    let size = proxy.frame(in: .local)
                    Image(card.img)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .opacity(0.5)
                        .distortionEffect(
                            shader(
                                offset: context.date.timeIntervalSince1970 - startDate.timeIntervalSince1970,
                                angle: context.date.timeIntervalSince1970 - startDate.timeIntervalSince1970,
                                width: size.width,
                                height: size.height
                            ),
                            maxSampleOffset: CGSize(width: 100, height: 100)
                        )
                }
                
                Text(card.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .padding()
                    .distortionEffect(
                        shader(
                            offset: context.date.timeIntervalSince1970 - startDate.timeIntervalSince1970
                        ),
                        maxSampleOffset: CGSize(width: 100, height: 100)
                    )
                    .shadowUniversal(radius: 10, y: 0)
            }
        }
    }
}
