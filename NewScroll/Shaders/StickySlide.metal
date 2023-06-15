//
//  StickySlide.metal
//  NewScroll
//
//  Created by Astemir Eleev on 14/06/2023.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] float2 stickySlide(float2 position,
                                    float2 size,
                                    float time,
                                    float direction) {
    float2 c = size / 2;
    float2 v = position - c;
    float f = (direction > 0 ? position.x : (size.x - position.x)) / size.x;
    
    if(time > f) {
        float m = (time - f) / (1 - f);
        return c + v * m;
    } else {
        return float2(-1, -1);
    }
}
