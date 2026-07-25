#version 320 es
precision highp float;
in vec2 v_texcoord;
out vec4 fragColor;
uniform sampler2D tex;

const float vibrance = 0.35;

void main() {
    vec4 pixColor = texture(tex, v_texcoord);
    float avg = (pixColor.r + pixColor.g + pixColor.b) / 3.0;
    vec3 boosted = pixColor.rgb + (pixColor.rgb - vec3(avg)) * vibrance;
    fragColor = vec4(clamp(boosted, 0.0, 1.0), pixColor.a);
}