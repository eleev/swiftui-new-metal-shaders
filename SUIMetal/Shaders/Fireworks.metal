//
//  Fireworks.metal
//  NewScroll
//
//  Created by Astemir Eleev on 03.07.2023.
//

#include <metal_stdlib>
using namespace metal;

#define PI 3.141592653589793 // Define value of PI
#define EXPLOSION_SPEED 5 // Define the speed of the explosion
#define EXPLOSION_RADIUS_THRESHOLD 0.04 // Threshold of explosion radius
#define MOD3 float3(0.1031,0.11369,0.13787) // A set of 3 floats for use in hash31 function

// hash31 function used for generating pseudo-random number
float3 hash31(float p) {
    float3 p3 = fract(float3(p) * MOD3); // Multiple input by a set of floats and get the fractional part
    p3 += dot(p3, p3.yxz + 19.19); // Adding the dot product of p3 and its yxz swizzle plus a constant
    // Returns a fractional part of a new float3 made from various combinations of p3's components
    return fract(float3((p3.x + p3.y) * p3.z, (p3.x + p3.z) * p3.y, (p3.y + p3.z) * p3.x));
}

// Function to animate fireworks
[[ stitchable ]] half4 fireworks(float2 position,
                                 half4 color,
                                 float4 bounds,
                                 float time,
                                 float explositionCount,
                                 float spartksPerExplosition,
                                 float explosionDuration) {
    float aspectRatio = bounds.w / bounds.z; // Calculate the aspect ratio
    float2 uv = position / bounds.z; // Normalizing position
    float t = fmod(time + 10.0, 7200.0); // Modulate time to make the animation repeat
    float3 col = float3(0.0); // Initialize color to black
    float2 origin = float2(0.0); // Initialize origin
    
    // Loop through each explosion
    for (uint j = 0; j < explositionCount; ++j)
    {
        float3 oh = hash31((float(j) + 1234.1939) * 641.6974); // Generate a random number
        origin = float2(oh.x, oh.y) * 0.6 + 0.2; // Set origin coordinates based on random number
        origin.x *= aspectRatio; // Adjust the x coordinate based on aspect ratio
        t += (float(j) + 1.0) * 9.6491 * oh.z; // Randomize the spawning of explosions

        // Loop through each spark per explosion
        for (uint i = 0; i < spartksPerExplosition; ++i)
        {
            float3 h = hash31(float(j) * 963.31 + float(i) + 497.8943); // Generate another random number
            float a = h.x * PI * 2.0; // Random angle for the spark
            float rScale = h.y * EXPLOSION_RADIUS_THRESHOLD; // Random radius scale for the spark

            // Create explosion loop based on time
            if (fmod(t * EXPLOSION_SPEED, explosionDuration) > 2.0)
            {
                float r = fmod(t * EXPLOSION_SPEED, explosionDuration) * rScale; // Calculate the radius
                float2 sparkPos = float2(r * cos(a), r * sin(a)); // Calculate spark position
                
                float gravityInfluence = 0.04; // A constant that will be used to determine the effect of gravity on the spark. The lower this value, the more significant the effect of gravity on the spark's trajectory.
                float gravityScale = (length(sparkPos) - (rScale - gravityInfluence)) / gravityInfluence; // Gravity scale factor for the current spark
                sparkPos.y += pow(gravityScale, 3.0) * 6e-5; // Add the gravity effect to the spark. Note that the gravity is reversed
                
                float spark = 0.0002 / pow(length(uv - sparkPos - origin), 1.65); // Calculate the color intensity of the spark

                // Make the explosion spark shimmer/sparkle
                float sd = 2.0 * length(origin - sparkPos);
                float shimmer = max(0.0, sqrt(sd) * (sin((t + h.y * 2.0 * PI) * 20.0)));
                
                float shimmerThreshold = explosionDuration * 0.32; // Define the shimmer threshold
                float fade = max(0.0, (explosionDuration - 5.0) * rScale - r); // Calculate the fade out effect
                
                // Mix all the properties together to get the final color of the spark
                col += spark * mix(1.0, shimmer, smoothstep(shimmerThreshold * rScale, (shimmerThreshold + 1.0) * rScale , r)) * fade * oh;
            }
        }
    }
    
    // Add an evening-ish background gradient
    col = max(float3(0.05), col);
    col += float3(0.12, 0.06, 0.02) * (1.0 - uv.y);
    
    return half4(col.r, col.g, col.b, 1.0); // Return the final color
}
