#version 320 es
precision highp float;
in vec2 v_texcoord;
out vec4 fragColor;
uniform sampler2D tex;

void main() {
    vec4 pixColor = texture(tex, v_texcoord);
    float r = dot(pixColor.rgb, vec3(0.393, 0.769, 0.189));
    float g = dot(pixColor.rgb, vec3(0.349, 0.686, 0.168));
    float b = dot(pixColor.rgb, vec3(0.272, 0.534, 0.131));
    fragColor = vec4(clamp(vec3(r, g, b), 0.0, 1.0), pixColor.a);
}