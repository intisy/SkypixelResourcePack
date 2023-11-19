#version 150

#define COLOR_BLACK vec3(0./255., 0./255., 0./255.)
#define COLOR_DARK_BLUE vec3(0./255., 0./255., 170./255.)
#define COLOR_DARK_GREEN vec3(0./255., 170./255., 0./255.)
#define COLOR_DARK_AQUA vec3(0./255., 170./255., 170./255.)
#define COLOR_DARK_RED vec3(170./255., 0./255., 0./255.)
#define COLOR_DARK_PURPLE vec3(170./255., 0./255., 170./255.)
#define COLOR_GOLD vec3(255./255., 170./255., 0./255.)
#define COLOR_GRAY vec3(170./255., 170./255., 170./255.)
#define COLOR_DARK_GRAY vec3(85./255., 85./255., 85./255.)
#define COLOR_BLUE vec3(85./255., 85./255., 255./255.)
#define COLOR_GREEN vec3(85./255., 255./255., 85./255.)
#define COLOR_AQUA vec3(85./255., 255./255., 255./255.)
#define COLOR_RED vec3(255./255., 85./255., 85./255.)
#define COLOR_LIGHT_PURPLE vec3(255./255., 85./255., 255./255.)
#define COLOR_YELLOW vec3(255./255., 255./255., 85./255.)
#define COLOR_WHITE vec3(255./255., 255./255., 255./255.)

uniform sampler2D DiffuseSampler;

in vec2 texCoord;
in vec2 oneTexel;

out vec4 fragColor;

void main(){
    vec4 center = texture(DiffuseSampler, texCoord);
    vec3 baseColor = center.rgb;

    vec4 left = texture(DiffuseSampler, texCoord - vec2(oneTexel.x, 0.0));
    vec4 right = texture(DiffuseSampler, texCoord + vec2(oneTexel.x, 0.0));
    vec4 up = texture(DiffuseSampler, texCoord - vec2(0.0, oneTexel.y));
    vec4 down = texture(DiffuseSampler, texCoord + vec2(0.0, oneTexel.y));

    if (baseColor == COLOR_GRAY) {
        baseColor = vec3(1., 166./255., 24./255.);
    }

    center = vec4(baseColor.rgb, center.a);
    left = vec4(baseColor.rgb, left.a);
    right = vec4(baseColor.rgb, right.a);
    up = vec4(baseColor.rgb, up.a);
    down = vec4(baseColor.rgb, down.a);

    float leftDiff  = abs(center.a - left.a);
    float rightDiff = abs(center.a - right.a);
    float upDiff    = abs(center.a - up.a);
    float downDiff  = abs(center.a - down.a);
    float total = clamp(leftDiff + rightDiff + upDiff + downDiff, 0.0, 1.0);
    vec3 outColor = center.rgb * center.a + left.rgb * left.a + right.rgb * right.a + up.rgb * up.a + down.rgb * down.a;
    fragColor = vec4(outColor.rgb * 0.2, total);
}
