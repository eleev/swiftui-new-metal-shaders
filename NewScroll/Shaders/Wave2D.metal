//
//  Wave2D.metal
//  NewScroll
//
//  Created by Astemir Eleev on 11/06/2023.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] float2 wave2d(float2 position, float time) {
    float waveFrequency = 15.0;
    float waveAmplitude = 5.0;
    float2 wavePosition = position / waveFrequency;
    return position + waveAmplitude * float2(sin(time * 2 + wavePosition.x), sin(time * 1.5 + wavePosition.y));
}
