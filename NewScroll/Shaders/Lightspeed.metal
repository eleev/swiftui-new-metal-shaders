//
//  Lightspeed.metal
//  NewScroll
//
//  Created by Astemir Eleev on 03.07.2023.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] half4 lightspeed(float2 position,
                                  half4 color,
                                  float4 bounds,
                                  float time,
                                  float raysn,
                                  float fx,
                                  float fy) {
    // Normalized pixel coordinates (from -1 to 1)
    float2 suv = (position.xy - 0.5 * bounds.wz) / bounds.w;
    
    // Radial UVs
    float2 uv = float2(length(suv), atan2(suv.y, suv.x));
    
    // Stars
    float offset = 0.1 * sin(uv.y * 10.0 - time * 0.6) * cos(uv.y * 48.0 + time * 0.3) * cos(uv.y * 3.7 + time);
    half3 rays = (sin(uv.y * raysn + time) * 0.5 + 0.5) *
    (sin(uv.y * fx - time * 0.6) * 0.5 + 0.5) *
    (sin(uv.y * fy + time * 0.8) * 0.5 + 0.5) *
    (1.0 - cos(uv.y + 22.0 * time - pow(uv.x + offset, 0.3) * 60.0)) *
    (uv.x * 2.0);
    
    return half4(rays.rg * 0.7, rays.b, 1.0);
}
