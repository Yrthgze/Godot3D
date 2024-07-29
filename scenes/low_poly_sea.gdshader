shader_type spatial;

uniform float height_scale = 0.5;
uniform sampler2D noise;
uniform sampler2D normalmap;

varying vec2 tex_position;
varying vec2 tex_position2;

void vertex() {
  tex_position = VERTEX.xz / 2.0 + 0.5;
  tex_position2 = (-1.0 + VERTEX.xz ) / 2.0;
  float height = texture(noise, tex_position2).x;
  VERTEX.y += height * height_scale;
}

void fragment() {
  NORMAL_MAP = texture(normalmap, tex_position2).xyz;
}