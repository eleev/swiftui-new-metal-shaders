//
//  Psychodelics.swift
//  NewScroll
//
//  Created by Astemir Eleev on 03.07.2023.
//

import SwiftUI

struct Psychodelics: View {
    private let date = Date()
    
    var body: some View {
        List {
            TimelineView(.animation) {
                let time = date.timeIntervalSince1970 -  $0.date.timeIntervalSince1970
                
                Rectangle()
                    .aspectRatio(1, contentMode: .fit)
                    .colorEffect(ShaderLibrary.psychodelics(
                        .boundingRect,
                        .float(time)
                    ))
            }
            .clipShape(RoundedRectangle(cornerRadius: 24))
        }
    }
}

#Preview("Psychodelics") {
    Psychodelics()
}
