shader_type spatial;

uniform float height_scale = 0.5;
uniform sampler2D noise;
uniform sampler2D normalmap;

varying vec2 tex_position;
varying vec2 tex_position2;

void vertex() {
//[-1, 1] ->[0,1] { (x+1)/2 } | [-1,1] -> [1, 0] { -(x+1)/2 + 1 }
  tex_position = (VERTEX.xz + 1.0) / 2.0;
  tex_position2 = -(VERTEX.xz + 1.0) / 2.0 + 1.0;
  float height = texture(noise, tex_position).x;
  VERTEX.y += height * height_scale;
}

void fragment() {
  NORMAL_MAP = texture(normalmap, tex_position).xyz;
}