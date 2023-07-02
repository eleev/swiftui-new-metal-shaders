//
//  GradientWave.metal
//  NewScroll
//
//  Created by Astemir Eleev on 01.07.2023.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] half4 gradientWave(float2 position,
                                    half4 color,
                                    float4 bounds,
                                    float time,
                                    half4 wcolor,
                                    float thinness,
                                    float speed,
                                    float scale) {
    vector_float2 uv = position / bounds.zw;
    uv = (uv - 0.5) * 2.;
    uv.x *= (bounds.z / bounds.w);
    
    half3 finalColor = half3(wcolor);
    float off = time * .12;
    float amp = sin(uv.x * thinness);
    float amp2 = sin(uv.x * scale);
    
    finalColor.x = pow(1. - distance(float2(uv.x, (sin((uv.x + off) * 40.) * .25 * amp - uv.y + .5) * amp2), uv),3.);
    if(finalColor.x > .95) {
        finalColor.y = pow(1. - distance(uv, float2(.0)), 2.);
    }
    
    return half4(finalColor, 1.);
}


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
