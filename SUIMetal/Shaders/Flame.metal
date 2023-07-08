//
//  Flame.metal
//  NewScroll
//
//  Created by Astemir Eleev on 07.07.2023.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] half4 candleFlame(float2 position,
                                   half4 color,
                                   float4 bounds,
                                   float time,
                                   float bloom,
                                   float2 motion,
                                   float3 colmult) {
    // Normalized pixel coordinates (from 0 to 1)
    float2 uv = 1. - (position.xy / bounds.wz);
    float2 nuv = uv;
    float aspect = bounds.w / bounds.z;
    nuv.x *= aspect;
    
    float2 pos = uv * 2.0 - float2(1.0, 1.0);
    
    // create horizontal flame variation
    pos.x += sin(time * 0.1) * uv.y * (sin(time - uv.y) + cos((time - uv.y) * 0.1)) * 3.141516 * motion.x;
    
    // create vertical flame variation
    pos.y += motion.y * fract(sin(30.0 * time)) + motion.y * sin(time);
    
    // select background to black
    float3 tcolor = float3(0., 0., 0.);
    
    // set scale of flame
    float p = 0.002;
    
    // create shape of flame (output y)
    float y = pow(abs(pos.x), 3.14 + cos(time) * 0.1) / (1.0 * p) * 1.0;
    
    // create the height of flame
    float flame_out = length(pos + float2(pos.x, y + 0.2)) * sin(0.8);
    
    // fix colors flame by RGB
    tcolor.rg += smoothstep(0.05 + colmult.x, 0.25 + colmult.y, 0.5 + colmult.z - flame_out);
    
    // fix color of flame by G (green)
    tcolor.g /= 2.4;
    
    // Slight blue to the base of the flame
    tcolor.b -= 0.3 * pos.y / flame_out;
    
    // Add bloom
    tcolor.rg += smoothstep(0.0, 10.1, 1.0 / distance(nuv, float2(pos.x + 0.25, (pos.y * 0.1 + 0.4)))) * bloom;
    tcolor.r += smoothstep(0.0, 5.1, 1.0 / distance(nuv, float2(pos.x + 0.25, (pos.y * 0.1 + 0.5)))) * bloom;
    
    // output color
    tcolor += pow(tcolor.r, 1.0);
    
    return half4(half3(tcolor), 1.0);
}
