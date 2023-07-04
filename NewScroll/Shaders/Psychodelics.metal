//
//  Psychodelics.metal
//  NewScroll
//
//  Created by Astemir Eleev on 03.07.2023.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] half4 psychodelics(float2 position,
                                    half4 color,
                                    float4 bounds,
                                    float time) {
    float2 uv = (position.xy - 0.5 * bounds.wz) / bounds.w;
    float2 cir = uv * uv + sin(uv.x * 15 + time) / 15.0
    * sin(uv.y * 7.0 + time * 1.75) / 2.0 + uv.x
    * sin(time) / 16.0 + uv.y * sin(time * 1.25) / 16.0;
    float circles = sqrt(abs(cir.x + cir.y * 0.5) * 35.0) * 5.0;
    
    return half4(sin(circles * 1.25 + 2.0), abs(sin(circles - 1.0) - sin(circles)), abs(sin(circles)), 1.0);
}
