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
