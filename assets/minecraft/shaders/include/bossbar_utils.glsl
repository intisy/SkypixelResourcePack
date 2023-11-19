#version 150

bool is_white_bossbar(vec2 texCoord0) {
    return texCoord0.y >= 60./256. && texCoord0.y <= 65./256.;
}

bool is_segmented_20_bossbar(vec2 texCoord0) {
    return texCoord0.y >= 110./256. && texCoord0.y <= 120./256.;
}

bool is_any_bossbar_edge(vec2 texCoord0) {
    return texCoord0.x == 182./256. || texCoord0.x == 0./256.;
}

bool is_white_or_segmented_20(vec2 texCoord0) {
    return is_white_bossbar(texCoord0) || is_segmented_20_bossbar(texCoord0);
}

bool is_white_or_segmented_20_vertex(vec2 texCoord0) {
    return is_any_bossbar_edge(texCoord0) && is_white_or_segmented_20(texCoord0);
}

int is_bossbar(vec3 Position, vec2 texCoord0, sampler2D Sampler0) {
//    Labymod renders on wrong z index
//    if (Position.z != 0.0) return 0;
    if (Position.z > 0.0) return 0;
    if (!is_white_or_segmented_20_vertex(texCoord0)) return 0;

    float textureCheck = textureLod(Sampler0, vec2(190./256., 3./256.), 0.0).a;
    if (textureCheck != 0.0) return 0;

    return 1;
}