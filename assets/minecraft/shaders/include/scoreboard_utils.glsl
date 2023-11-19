#version 150

bool is_scoreboard_header_color(vec4 color) {
    return color.a == 102.0/255.0;
}

bool is_scoreboard_number(vec3 Position, vec4 vertexColor) {
//    Labymod renders on wrong z index
//    if (Position.z != 0.0) return false;
    if (Position.z != 0.0 && Position.z != 0.03) return false;
    if (gl_VertexID > 7) return false;
    if (vertexColor.rgb != vec3(252./255., 84./255., 84./255.)) return false;
    if (gl_Position.x >= 0.91 && gl_Position.y >= -0.35 && gl_Position.y <= 0.75) return true;
    return false;
}