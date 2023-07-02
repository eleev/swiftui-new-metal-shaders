//
//  GlowingWave.metal
//  NewScroll
//
//  Created by Astemir Eleev on 30.06.2023.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] half4 waveg(float2 position,
                             half4 color,
                             float4 bounds,
                             float time,
                             half4 wcolor,
                             float thinness,
                             float yShift,
                             float scale) {
    vector_float2 uv = position / bounds.zw;
    uv = (uv - 0.5) * 2.;
    uv.x *= (bounds.z / bounds.w);
    
    half3 finalColor = half3(wcolor);
    float mag = 1.;
    uv = scale * uv;
    uv.y -= yShift;
    uv.y += sin(time + time) * tan(-time+time / 2) * sin(uv.x + time);
    mag = abs(1.0 / (thinness * uv.y));
    finalColor += half3(mag);
    finalColor += half3(cos(time*2 + half3(1.1, 1.2, 1.3) * sqrt(min(uv.y, 40.))));

    return half4(finalColor, 1.);
}
