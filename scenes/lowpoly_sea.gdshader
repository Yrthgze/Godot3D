shader_type spatial;
uniform sampler2D noise;
uniform sampler2D normalmap;
uniform float f_wave_speed = 2.0;
varying vec2 t_index;

float wave(float x_pos){
	return sin(TIME) * 50.0;
}
void vertex() {
	t_index = ((VERTEX.xz + 1.0) / 2.0);
	float t_height = texture(noise, t_index).x;
	float wave_height = sin(t_height * 10.0 + TIME * f_wave_speed)*10.0;
	VERTEX.y += wave_height;
}

void fragment() {
	NORMAL_MAP = texture(normalmap, t_index).xyz;
}

