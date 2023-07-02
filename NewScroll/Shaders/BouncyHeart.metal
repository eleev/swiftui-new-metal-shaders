//
//  BouncyHeart.metal
//  NewScroll
//
//  Created by Astemir Eleev on 26.06.2023.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

float mod(float a, float b) {
    return a - b * floor(a / b);
}

[[ stitchable ]] half4 heart(float2 position,
                             half4 color,
                             float4 bounds,
                             float time,
                             half4 baseColor,
                             half4 bkgColor,
                             float size) {
    
    vector_float2 uv = position / bounds.zw;
    uv = (uv - 0.5) * 3.; // center
    uv.y *= -1.;
    
    half3 bcol = half3(bkgColor.x*uv.x,bkgColor.y,bkgColor.z-0.07*uv.y) * (1.0-0.25*length(uv));
    float tt = mod(time, 9.5) / 9.5;
    float ss = pow(tt,.2) * 0.5 + 0.5;
    ss = 1.0 + ss * 0.5 * sin(tt * 6.2831 * 3.0 + uv.y * 0.5) * exp(-tt*0.5);
    uv *= float2(0.5,1.5) + ss * float2(0.5,-0.5);
    
    float a = atan2(uv.x,uv.y)/3.141593;
    float r = length(uv) + size;
    float h = abs(a);
    float d = (13.0 * h - 22.0 * h * h + 10.0 * h * h * h) / (6.0 - 5.0 * h);
    
    float s = 0.75 + 0.75 * uv.x;
    s *= 1.0 - 0.25 * r;
    s = 0.5 + 0.6 * s;
    s *= 0.5 + 0.5 * pow(1.0 - clamp(r / d, 0.0, 1.0), 0.1);
    half3 hcol = half3(baseColor) * s;
    
    half3 col = mix(bcol, hcol, smoothstep(-0.03, 0.03, d - r));
    
    return half4(col, 1.0);
}
