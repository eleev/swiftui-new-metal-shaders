//
//  Noise.metal
//  NewScroll
//
//  Created by Astemir Eleev on 21.06.2023.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] half4 noise(float2 position, half4 currentColor, float time) {
    float value = fract(sin(dot(position + time, float2(12.9898, 78.233))) * 43758.5453);
    return half4(value, value, value, 1) * currentColor.a;
}
