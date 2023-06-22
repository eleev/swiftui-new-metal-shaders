//
//  PixellateView.swift
//  NewScroll
//
//  Created by Astemir Eleev on 21.06.2023.
//

import SwiftUI

struct PixellateView: View {
    @State private var strength: CGFloat = 0
    
    var body: some View {
        List {
            Image(.flagOfCalifornia)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .distortionEffect(
                    ShaderLibrary.pixellate(
                        .float(strength)
                    ),
                    maxSampleOffset: .zero
                )
            Section("Strength") {
                Slider(value: $strength, in: 0...20)
            }
        }
    }
}

#Preview {
    PixellateView()
}
