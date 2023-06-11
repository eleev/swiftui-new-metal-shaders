//
//  Kaleidoscope.metal
//  NewScroll
//
//  Created by Astemir Eleev on 09/06/2023.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] float2 kaleidoscope(float2 position,
                                     float2 size,
                                     float2 offset,
                                     float count,
                                     float angle,
                                     float scale) {
    float pi = M_PI_F;
    
    float w = size.x;
    float h = size.y;
    float aspect = w / h;
    
    float x = offset.x / w;
    float y = offset.y / h;
    
    float u = position.x / w;
    float v = position.y / h;
    
    float ux = (u - 0.5 - x) * aspect;
    float vy = v - 0.5 - y;
    
    float ang = atan2(ux, vy) / (pi * 2) + 0.5;
    float ang_count = ang * count;
    float ang_step = ang_count - floor(ang_count);
    if ((ang_count / 2) - floor(ang_count / 2) > 0.5) {
        ang_step = 1.0 - ang_step;
    }
    float ang_kaleidoscope = (ang_step / count) * (pi * 2);
    ang_kaleidoscope += angle;
    
    float distance = sqrt(pow((u - 0.5) * aspect - x, 2) + pow(v - 0.5 + y, 2)) / scale;
    float2 uv = float2((cos(ang_kaleidoscope) / aspect) * distance + x, sin(ang_kaleidoscope) * distance - y) + 0.5;
    
    return float2(uv.x * w, uv.y * h);
}
