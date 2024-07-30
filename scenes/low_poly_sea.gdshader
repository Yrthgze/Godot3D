shader_type spatial;

uniform float height_scale = 0.5;
uniform sampler2D noise;
uniform sampler2D normalmap;

varying vec2 tex_position;
varying vec2 tex_position2;
float wave(vec2 position){
  position += texture(noise, position / 10.0).x * 2.0 - 1.0;
  vec2 wv = 1.0 - abs(sin(position));
  return pow(1.0 - pow(wv.x * wv.y, 0.65), 4.0);
}
float height(vec2 position, float time){
	float d = wave((position + time) * 0.4) * 0.3;
    d += wave((position - time) * 0.3) * 0.3;
    d += wave((position + time) * 0.5) * 0.2;
    d += wave((position - time) * 0.6) * 0.2;
    return d;
}

void vertex() {
//[-1, 1] ->[0,1] { (x+1)/2 } | [-1,1] -> [1, 0] { -(x+1)/2 + 1 }
  tex_position = (VERTEX.xz + 1.0) / 2.0;
  tex_position2 = -(VERTEX.xz + 1.0) / 2.0 + 1.0;
  float k = height(tex_position, TIME);
  VERTEX.y += k * height_scale;
  NORMAL = normalize(vec3(k - height(tex_position + vec2(0.1, 0.0), TIME), 0.1, k - height(tex_position + vec2(0.0, 0.1), TIME)));
}

void fragment() {
  //NORMAL_MAP = texture(normalmap, tex_position).xyz;
  float fresnel = sqrt(1.0 - dot(NORMAL, VIEW));
  METALLIC = 0.2;
  RIM = 0.2;
  ROUGHNESS = 0.05 * (1.0 - fresnel);;
  ALBEDO = vec3(0.1, 0.3, 0.5) + (0.1 * fresnel);
}