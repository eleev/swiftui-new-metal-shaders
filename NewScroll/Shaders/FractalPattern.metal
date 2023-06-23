//
//  FractalPattern.metal
//  NewScroll
//
//  Created by Astemir Eleev on 22.06.2023.
//

#include <metal_stdlib>
using namespace metal;

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

/// Random pallette generator
half3 palette(float t) {
    half3 a = half3(0.5, 0.5, 0.5);
    half3 b = half3(0.5, 0.5, 0.5);
    half3 c = half3(1.0, 1.0, 1.0);
    half3 d = half3(0.263, 0.416, 0.557);
    return a + b * cos(6.28318 * (c * t * d));
}

[[ stitchable ]] half4 fractalPattern(
                                      float2 position,
                                      half4 color,
                                      float4 bounds,
                                      float time,
                                      float iterations,
                                      float repeatness,
                                      float phase) {
    vector_float2 uv = position / bounds.zw;
    uv = (uv - 0.5) * 2.; // center
    uv.x *= (bounds.z / bounds.w); // correct aspect ratio
    
    half3 finalColor = half3(0.0);
    vector_float2 uv0 = uv;
    
    for(float i = 0.0; i < iterations; i++) {
        uv = fract(uv * repeatness) - 0.5; // repeat the space and center
        
        float d = length(uv) * exp(-length(uv0));
        half3 col = palette(length(uv0) + i * .4 + time * .4); // half3(1.0, 2.0, 3.0);
        
        d = sin(d * phase + time) / 8.;
        d = abs(d); // make it glow
        d = pow(0.01 / d, 1.2); // increase contrast
        
        finalColor += col * d;
    }
    
    return half4(finalColor, 1.);
}
