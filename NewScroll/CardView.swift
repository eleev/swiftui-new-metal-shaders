//
//  CardView.swift
//  NewScroll
//
//  Created by Astemir Eleev on 08/06/2023.
//

import SwiftUI

struct CardView: View {
    @Binding var card: Card
    
    private func shader(offset: CGFloat) -> Shader {
        Shader(function: .init(library: .default, name: "wave"), arguments: [.float(offset)])
    }
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
        RoundedRectangle(cornerRadius: 24)
            .fill(.ultraThinMaterial)
            .overlay(alignment: .top, content: mainCard)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .modifier(OutlineModifier(cornerRadius: 24))
            .padding(.bottom, 32)
            .overlay(alignment: .bottom, content: bottomCard)
            .shadowUniversal(radius: 5, y: -10)
    }
    
    private func bottomCard() -> some View {
        RoundedRectangle(cornerRadius: 24)
            .fill(.ultraThinMaterial)
            .modifier(OutlineModifier(cornerRadius: 24))
            .shadowUniversal(radius: 5, y: -10)
            .overlay(
                alignment: .bottomTrailing,
                content: bottomTrailingCard
            )
            .overlay(alignment: .top) {
                
                VStack(spacing: 24) {
                    Text(card.desc)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                    controlGrid
                }
                .padding()
            }
            .containerRelativeFrame(
                .vertical,
                count: 18,
                span: 5,
                spacing: 16
            )
            .padding(.horizontal, 32)
    }
    
    private var controlGrid: some View {
        Grid(alignment: .leading) {
            GridRow {
                Group {
                    Text("Size")
                    Text("Type")
                    Text("Date")
                }
                .foregroundStyle(.secondary)
                .fontWeight(.semibold)
            }
            
            Divider()
                .gridCellUnsizedAxes(.vertical)
            
            GridRow {
                Group {
                    Text("128x128")
                    Text("Capital")
                    
                    lazy var date: String = {
                        let formatter = DateFormatter()
                        formatter.dateStyle = .none
                        formatter.timeStyle = .short
                        return formatter.string(from: card.date)
                    }()
                    Text("\(date)")
                        .lineLimit(2)
                }
                .font(.caption)
                .fontWeight(.semibold)
            }
        }
    }
    
    private func mainCard() -> some View {
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
    
    private func bottomTrailingCard() -> some View {
        HStack(spacing: 64) {
            ControlGroup {
                Button(action: {}) {
                    Image(systemName: "ellipsis")
                }
                Button(action: {}) {
                    Image(systemName: "plus.magnifyingglass")
                }
                Button(action: {}) {
                    Image(systemName: "face.dashed")
                }
            }
            
            Image(systemName: card.symbol)
                .symbolEffect(.variableColor.reversing)
                .symbolRenderingMode(.hierarchical)
                .imageScale(.large)
        }
        .padding()
    }
}

#Preview {
    CardView(card: .constant(Model().cards[0]))
        .preferredColorScheme(.dark)
        .previewDisplayName("CardView")
}


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
