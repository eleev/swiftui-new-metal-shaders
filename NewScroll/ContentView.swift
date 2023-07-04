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
    
    @ViewBuilder
    private var scrollables: some View {
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
    }
    
    @ViewBuilder
    private var deform: some View {
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
    
        lazy var pixellate = "Pixellate"
        NavigationLink(pixellate) {
            PixellateView()
                .navigationTitle(pixellate)
        }
    }
    
    @ViewBuilder
    private var glowing: some View {
        lazy var fractalPattern = "Fractal Neon Pattern"
        NavigationLink(fractalPattern) {
            FractalPattern()
                .navigationTitle(fractalPattern)
        }
        
        lazy var glowingWave = "Glowing Wave"
        NavigationLink(glowingWave) {
            GlowingWave()
                .navigationTitle(glowingWave)
        }
        
        lazy var circlePattern = "Circle Pattern"
        NavigationLink(circlePattern) {
            CirclePattern()
                .navigationTitle(circlePattern)
        }
    }
    
    var body: some View {
        NavigationStack{
            List{
                Section("Scrollables") {
                    scrollables
                }
                Section("Deformations") {
                    deform
                }
                Section("Glowing") {
                    glowing
                }
                
                lazy var mandelbrot = "Mandelbrot"
                NavigationLink(mandelbrot) {
                    Mandelbrot()
                        .navigationTitle(mandelbrot)
                }
                
                lazy var bouncyHeart = "Bouncy Heart"
                NavigationLink(bouncyHeart) {
                    BouncyHeart()
                        .navigationTitle(bouncyHeart)
                }
                
                lazy var gradientWave = "Gradient Wave"
                NavigationLink(gradientWave) {
                    GradientWave()
                        .navigationTitle(gradientWave)
                }
                
                lazy var lightspeed = "Lightspeed"
                NavigationLink(lightspeed) {
                    Lightspeed()
                        .navigationTitle(lightspeed)
                }
                
                lazy var psychodelics = "Psychodelics"
                NavigationLink(psychodelics) {
                    Psychodelics()
                        .navigationTitle(psychodelics)
                }
                
                lazy var fireworks = "Fireworks"
                NavigationLink(fireworks) {
                    Fireworks()
                        .navigationTitle(fireworks)
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
