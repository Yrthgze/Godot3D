shader_type spatial;
uniform sampler2D noise;
uniform sampler2D normalmap;
uniform float f_wave_speed = 2.0;
varying vec2 t_index;

void vertex() {
	t_index = (VERTEX.xz + 1.0) / 2.0;
	float t_height = texture(noise, t_index).x;
	float wave_height = sin(t_height * 10.0 + TIME * f_wave_speed)*10.0;
	VERTEX.y += wave_height;
}

void fragment() {
	// Recupera los valores de la textura de normales
    vec3 normal_from_map = texture(normalmap, UV).xyz;

    // Convierte el rango de [0, 1] a [-1, 1]
    normal_from_map = normal_from_map * 2.0 - 1.0;

    // Asigna la normal ajustada
    NORMAL = normalize(normal_from_map);
}

