#version 150

#moj_import <bossbar_utils.glsl>

uniform sampler2D Sampler0;
uniform vec4 ColorModulator;

in vec2 texCoord0;
flat in int bossbar;

out vec4 fragColor;

void main() {
    vec4 color = texture(Sampler0, texCoord0);

    if (color.a == 0.0) {
        discard;
    }

    if (bossbar == 1 && is_white_or_segmented_20(texCoord0)) {
        discard;
    }

    fragColor = color * ColorModulator;
}
