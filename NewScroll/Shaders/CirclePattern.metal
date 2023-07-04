//
//  CirclePattern.metal
//  NewScroll
//
//  Created by Astemir Eleev on 03.07.2023.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] half4 circlePattern(float2 position,
                                     half4 color,
                                     float4 bounds,
                                     float time,
                                     half4 wcolor,
                                     float iterations) {
    int2 F = 80;
    float2 r = float2(position.x, position.y);
    float2 u = (float2(F+F) - r) / r.y;
    float3 col = float3(wcolor.rbg);
    
    for (float i=0.; i<iterations; i++) {
        col += 0.004 / (abs(length(u * u) - i * 0.04) + 0.005)
        * (cos(i + float3(0,1,2)) + 1.)
        * smoothstep(0.35, 0.4, abs(abs(fmod(time, 2.0) - i * 0.1) - 1.0));
        
        float angle = (time + float(i++)) * 0.03 + 3.14159265359 / 2.0;
        float2x2 rotMatrix = float2x2(cos(angle), -sin(angle), sin(angle), cos(angle));
        u *= rotMatrix;

    }
    
    return half4(half3(col.x, col.y, col.z), 1.);
}
