//
//  FractalPattern.metal
//  NewScroll
//
//  Created by Astemir Eleev on 22.06.2023.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

[[ stitchable ]] half4 mandelbrot(float2 position,
                                  half4 color,
                                  float4 bounds,
                                  float time,
                                  half4 baseColor,
                                  float iterations) {
    vector_float2 uv = position / bounds.zw;
    uv = (uv - 0.5) * 2.; // center
    uv.x *= (bounds.z / bounds.w); // correct aspect ratio
    uv.x -= 0.5; // shift along x axis
    
    vector_float2 z = log(uv * uv + exp(uv.x * uv.x + uv.y * uv.y + 0.247814));
    z += 4. * ((uv.x * uv.y - z.x * z.y) * 1.618033 + length(uv - z));
    // Approximated iteration count
    float i = dot(z, z) + log(2. * z.x * z.y);
    half4 rcolor = baseColor;
    
    for(i = 0., z *= i; i++<1e2; z = vector_float2(z.x * z.x - z.y * z.y, iterations * z.x * z.y) + uv) {
        if(dot(z, z) > 40.) {
            // Smooth iteration count to avoid banding
            float i_smoothed = i + 1. -log(log(dot(z, z))) / log(2.);
            // Colorize
            rcolor = half4(cos(time + half3(1.1, 1.2, 1.3) * sqrt(min(i_smoothed, 40.))), 1);
            break;
        }
    }
    return rcolor;
}
