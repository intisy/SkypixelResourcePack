#version 150

#moj_import <fog.glsl>
#moj_import <scoreboard_utils.glsl>
#moj_import <text_shadow_utils.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler0;
uniform sampler2D Sampler1;
uniform sampler2D Sampler2;

uniform vec4 ColorModulator;
uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform mat3 IViewRotMat;
uniform int FogShape;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    vertexDistance = fog_distance(ModelViewMat, IViewRotMat * Position, FogShape);
    vec4 texColor = texelFetch(Sampler2, UV2 / 16, 0);
    vertexColor = Color * texColor;
    texCoord0 = UV0;
    vec3 colorWithoutAlpha = vertexColor.rgb;

    bool is_gui = Position.z == 0.0;

    if (is_scoreboard_number(Position, vertexColor)) {
        gl_Position = ProjMat * ModelViewMat * vec4(Position.x + 100, Position.y, Position.z, 0);
        vertexColor = vec4(0);
    } else if (is_text_shadow(Position, Sampler0, UV2, vertexColor, ColorModulator, vec4(0, 0, 0, 128./255.))) {
        vertexColor = vec4(0);
    } else if (is_gui && is_modded_scoreboard_shadow(Color)) {
        vertexColor = vec4(0);
    }
}
