//
//  ShaderTest.swift
//  NewScroll
//
//  Created by Astemir Eleev on 11/06/2023.
//

import SwiftUI

struct ShaderTest: View {
    private func shader(offset: CGFloat, angle: CGFloat, width: CGFloat, height: CGFloat) -> Shader {
        Shader(
            function: .init(library: .default, name: "kaleidoscope"), arguments: [
                Shader.Argument.float2(width, height),
                Shader.Argument.float2(offset, offset),
                Shader.Argument.float(22),
                Shader.Argument.float(angle),
                Shader.Argument.float(1.0),
        ])
    }
    private let startDate = Date()
    
    var body: some View {
        GeometryReader { proxy in
            TimelineView(.animation) { context in
                Text("Hello, SwiftUI Shaders!")
                    .font(.title)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .scaleEffect(x: 1.8, y: 1.0, anchor: .center)
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .padding()
                    .distortionEffect(
                        shader(
                            offset: context.date.timeIntervalSince1970 - startDate.timeIntervalSince1970,
                            angle: context.date.timeIntervalSince1970 - startDate.timeIntervalSince1970,
                            width: proxy.size.width,
                            height: proxy.size.height
                        ),
                        maxSampleOffset: CGSize(width: 100, height: 100)
                    )
            }
        }
    }
}

#Preview {
    ShaderTest()
        .preferredColorScheme(.dark)
        .previewDisplayName("ShaderTest")
}
