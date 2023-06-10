//
//  ContentView.swift
//  NewScroll
//
//  Created by Astemir Eleev on 08/06/2023.
//

import SwiftUI
import Observation

struct ContentView: View {
    @Bindable private var model = Model()
    
    var body: some View {
        NavigationStack{
            List{
                lazy var veticalStackTitle = "Vertical Stack"
                NavigationLink(veticalStackTitle) {
                    VerticalStack(model: model)
                        .navigationTitle(veticalStackTitle)
                }
                
                lazy var horizontalDeckTitle = "Horizontal Deck"
                NavigationLink(horizontalDeckTitle) {
                    HorizontalDeck(model: model)
                        .navigationTitle(horizontalDeckTitle)
                }
            }
        }
    }
    
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
        .previewDisplayName("ContentView")
}
