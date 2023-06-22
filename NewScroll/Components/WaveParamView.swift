//
//  WaveParamView.swift
//  NewScroll
//
//  Created by Astemir Eleev on 21.06.2023.
//

import SwiftUI

struct WaveParamView: View {
    @State private var speed: CGFloat = 3
    @State private var frequency: CGFloat = 25
    @State private var amplitude: CGFloat = 10
    @State private var isForward: Bool = true
    
    private var date = Date()
    
    var body: some View {
        List {
            TimelineView(.animation) { context in
                let time = context.date.timeIntervalSince1970 - date.timeIntervalSince1970
                
                Image(._2)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .distortionEffect(
                        ShaderLibrary.waveParamed(
                            .float(time),
                            .float(speed),
                            .float(frequency),
                            .float(amplitude),
                            .float(isForward ? 1 : 0)
                        ),
                        maxSampleOffset: .zero
                    )
            }
            Section("Frequency") {
                Slider(value: $frequency, in: 1...50)
            }
            Section("Amplitude") {
                Slider(value: $amplitude, in: 1...35)
            }
            Section("Speed") {
                Slider(value: $speed, in: 1...15)
            }
            Section("Simulation Direction") {
                Button(action: { isForward.toggle() }) {
                    Image(systemName: isForward ? "forward" : "backward")
                        .symbolEffect(.pulse)
                    Text(isForward ? "Forward" : "Backward")
                }
                .buttonRepeatBehavior(.disabled)
                .buttonStyle(.borderedProminent)
                .containerRelativeFrame(.horizontal)
            }
        }
    }
}

#Preview {
    WaveParamView()
}

