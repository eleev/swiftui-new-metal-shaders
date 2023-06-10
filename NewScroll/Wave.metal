//
//  Wave.metal
//  NewScroll
//
//  Created by Astemir Eleev on 09/06/2023.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

[[ stitchable ]] float2 wave(float2 position, float time) {
    return position+float2(0, sin(time * 2 + position.x / 15)) * 5;
}
