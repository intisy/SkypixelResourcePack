#version 150

vec4 make_emissive(vec4 defaultColor, vec4 pixelColor, vec4 vertexColor, vec4 ColorModulator) {
    float alpha = pixelColor.a;

    if (alpha == 254./255.) {
        pixelColor.a = 1;
        return pixelColor * mix(vertexColor, vec4(1.), 2) * ColorModulator;
    } else if (alpha == 234./255.) {
        pixelColor.a = 230./255.; // 90% transparency
        return pixelColor * mix(vertexColor, vec4(1.), 2) * ColorModulator;
    } else if (alpha == 233./255.) {
        pixelColor.a = 204./255.; // 80% transparency
        return pixelColor * mix(vertexColor, vec4(1.), 2) * ColorModulator;
    } else if (alpha == 154./255.) {
        pixelColor.a = 153./255.; // 60% transparency
        return pixelColor * mix(vertexColor, vec4(1.), 2) * ColorModulator;
    } else if (alpha == 103./255.) {
        pixelColor.a = 102./255.; // 40% transparency
        return pixelColor * mix(vertexColor, vec4(1.), 2) * ColorModulator;
    } else if (alpha == 249./255.) {
        pixelColor.a = 1;
        return pixelColor * vertexColor * vec4(2.) * ColorModulator;
    }

    return defaultColor;
}
