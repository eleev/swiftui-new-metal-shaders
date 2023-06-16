//
//  Community.metal
//  NewScroll
//
//  Created by Astemir Eleev on 15.06.2023.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

// MARK: - Apollonian Gasket
/* Direct port from WebGL */

float apollonianGasket_df(float2 p, float iTime, float scale, float z) {
    const float zoom = 0.5f;
    p /= zoom;
    
    float tm = 0.1f * iTime;
    
    p = p * float2x2(cos(tm), sin(tm), -sin(tm), cos(tm));
    tm = 0.2f * iTime;
    float r = 0.5f;
    
    float4 off = float4(r*(0.5f+0.5f*sin(tm*sqrt(3.0f))),
                        r*(0.5f+0.5f*sin(tm*sqrt(1.5f))),
                        r*(0.5f+0.5f*sin(tm*sqrt(2.0f))),
                        0.0f);
    
    float4 pp = float4(p.x, p.y, 0.0f, 0.0f)+off;
    pp.w = 0.125f*(1.0f-tanh(length(pp.xyz)));
    
    float tmsqrt = tm*sqrt(0.5f);
    pp.yz = pp.yz * float2x2(cos(tm), sin(tm), -sin(tm), cos(tm));
    pp.xz = pp.xz * float2x2(cos(tmsqrt), sin(tmsqrt), -sin(tmsqrt), cos(tmsqrt));
    
    pp /= z;
    
    for(int i=0; i<7; ++i) {
        pp = -1.0f + 2.0f*fract(0.5f*pp+0.5f);
        float r2 = dot(pp,pp);
        
        float k  = 1.2/r2;
        pp      *= k;
        scale   *= k;
    }
    
    return  (abs(pp.y)/scale * z) * zoom;
    
}


[[ stitchable ]] half4 apollonianGasket(float2 fragCoord, half4 color, float4 bounds, float iTime, float z) {
    float2 iResolution = bounds.zw;
    
    float  Alpha      = 1.0f;
    float  Scale      = 1.0;
    float  Contrast   = 0.6;
    float  Saturation = 0.33;
    float  Vigneting  = 0.5;
    
    float2 q = fragCoord / iResolution.xy;
    float2 p = -1.0f + 2.0f * q;
    p.x *= iResolution.x/iResolution.y;
    
    
    float aa   = 2.0f/iResolution.y;
    const float lw = 0.0235f;
    const float lh = 1.25f;
    
    const float3 lp1 = float3(0.5f, lh, 0.5f);
    const float3 lp2 = float3(-0.5f, lh, 0.5f);
    
    float d = apollonianGasket_df(p, iTime, Scale, z);
    
    float b = -0.125f;
    float t = 10.0f;
    
    float3 ro = float3(0.0f, t, 0.0f);
    float3 pp = float3(p.x, 0.0f, p.y);
    
    float3 rd = normalize(pp - ro);
    
    float bt = -(t-b) / rd.y;
    
    float3 bp   = ro + bt*rd;
    float3 srd1 = normalize(lp1-bp);
    float3 srd2 = normalize(lp2-bp);
    float bl21= dot(lp1-bp,lp1-bp);
    float bl22= dot(lp2-bp,lp2-bp);
    
    float st1= (0.0f-b) / srd1.y;
    float3 sp1 = bp + srd1*st1;
    float3 sp2 = bp + srd2*st1;
    
    float sd1= apollonianGasket_df(sp1.xz,iTime,Scale,z);
    float sd2= apollonianGasket_df(sp2.xz,iTime,Scale,z);
    
    float3 col  = float3(.0);
    const float ss =15.0f;
    
    col += float3(1.) * (1.0f-exp(-ss*(fmax((sd1+0.0f*lw), 0.0f)))) / bl21;
    col += float3(.5) * (1.0f-exp(-ss*(fmax((sd2+0.0f*lw), 0.0f)))) / bl22;
    
    float l   = length(p);
    float hue = fract(0.75f * l-0.3f * iTime)+0.3f+0.15f;
    float sat = 0.75f*tanh(2.0f * l);
    float3 hsv  = float3(hue, sat, 1.0f);
    
    const float4 K = float4(1., 2. / 3., 1. / 3., 3.);
    float3 bcol = hsv.z * mix(K.xxx, clamp(fabs(fract(hsv.xxx + K.xyz) * 6.0f - K.www) - K.xxx, 0.0f, 1.0f), hsv.y);
    
    col *= (1.0f-tanh(0.75f*l))*0.5f;
    col  = mix(col, bcol, smoothstep(-aa, aa, -d));
    col += 0.5f*sqrt(bcol.zxy)*(exp(-(10.0f+100.0f*tanh(l))*fmax(d, 0.0f)));
    
    col  = pow(clamp(col,0.0f,1.0f),float3(1.0f/2.2f));
    col  = col*Contrast+0.4f*col*col*(3.0f-2.0f*col);
    col  = mix(col, float3( dot(col, float3(Saturation)) ), -0.4f);
    col *= 0.5f+0.5f*pow(19.0f*q.x*q.y*(1.0f-q.x)*(1.0f-q.y),Vigneting);
    
    return half4(col.x,col.y,col.z, Alpha);
    
}
