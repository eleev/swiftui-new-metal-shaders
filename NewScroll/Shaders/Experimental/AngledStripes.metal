//
//  AngledStripes.metal
//  NewScroll
//
//  Created by Astemir Eleev on 13.06.2023.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

[[ stitchable ]] half4 angledStripes(float2 position, float width, float angle, half4 color) {
    float magnitude = sqrt(position.x * position.x + position.y * position.y);
    float pAngle = angle + (position.x == 0.0f ? (M_PI_F / 2.0f) : atan (position.y / position.x));
    float rotatedX = magnitude * cos(pAngle);
    float rotatedY = magnitude * sin(pAngle);
    
    return (color + color * fmod(abs(rotatedX + rotatedY), width) /width) / 2;
}
