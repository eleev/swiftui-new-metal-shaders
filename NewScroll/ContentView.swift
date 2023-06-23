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
                
                lazy var horizontalShowcase = "Horizontal Showcase"
                NavigationLink(horizontalShowcase) {
                    OversettableStoreScrollView(model: model)
                        .navigationTitle(horizontalShowcase)
                }
                
                lazy var oversettableZStack = "Depth Stack"
                NavigationLink(oversettableZStack) {
                    OversettableCardStack()
                        .navigationTitle(oversettableZStack)
                }
                
                lazy var complexWave = "Param Wave"
                NavigationLink(complexWave) {
                    ComplexWaveView()
                        .navigationTitle(complexWave)
                }
                
                lazy var complexFlagWave = "Flag Wave"
                NavigationLink(complexFlagWave) {
                    WaveParamView()
                        .navigationTitle(complexFlagWave)
                }
                
                lazy var fractalPattern = "Fractal Neon Pattern"
                NavigationLink(fractalPattern) {
                    FractalPattern()
                        .navigationTitle(fractalPattern)
                }
                
                lazy var pixellate = "Pixellate"
                NavigationLink(pixellate) {
                    PixellateView()
                        .navigationTitle(pixellate)
                }
            }
            .navigationTitle("Scenes")
            .navigationBarTitleDisplayMode(.large)
            
        }
    }
    
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
        .previewDisplayName("ContentView")
}
