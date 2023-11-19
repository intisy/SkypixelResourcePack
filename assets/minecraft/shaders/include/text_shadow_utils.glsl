#version 150

bool is_text_shadow(vec3 Position, sampler2D Sampler0, ivec2 UV, vec4 vertexColor, vec4 ColorModulator, vec4 textColor) {
    if (Position.z != 0.03 && Position.z != 0.06 && Position.z != 0.12) return false;

    vec4 colorWithAlpha = texelFetch(Sampler0, UV / 16, 0) * vertexColor * ColorModulator;
    return colorWithAlpha == textColor;
}

// Check if text color is set to #fffff05 and remove text shadow
bool is_modded_scoreboard_shadow(vec4 Color) {
    return Color.r > 63./256. && Color.r < 64./256. && Color.g > 63./256. && Color.g < 64./256. && Color.b > 1.003/256. && Color.b < 1.004/256.;
}