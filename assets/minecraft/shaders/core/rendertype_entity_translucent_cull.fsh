#version 150

#moj_import <fog.glsl>
#moj_import <emissive_utils.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

in float vertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;

out vec4 fragColor;

void main() {
    vec4 rgb = texture(Sampler0, texCoord0);

    if (rgb.a == 240./255.) {
        if (vertexDistance < 1.3) {
            discard;
        } else {
            rgb.a = 1;
        }
    }

    vec4 color = rgb * vertexColor * ColorModulator;
    color = make_emissive(color, rgb, vertexColor, ColorModulator);

    if (color.a < 0.01)
        discard;

    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}