#version 150

in vec3 Position;
in vec4 Color;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;

out vec4 vertexColor;

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.);

    // Scoreboard header: Badlion default color replaced with Badlion scoreboard body default color
    if (Color == vec4(0, 0, 0, 96./255.) || Color == vec4(0, 0, 0, 80./255.)) {
        vertexColor = vec4(Color.rgb, 76./255.);
    // Scoreboard header: Vanilla default color replaced with Vanilla scoreboard body default color
    } else if (Color == vec4(0, 0, 0, 102./255.)) {
        vertexColor = vec4(Color.rgb, 76./255.);
    } else {
        vertexColor = Color;
    }
}
