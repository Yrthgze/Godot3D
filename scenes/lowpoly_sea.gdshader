shader_type spatial;
uniform sampler2D noise;
uniform sampler2D normalmap;

float wave(){
	return sin(TIME) * 50.0;
}
void vertex() {
	VERTEX.y = wave();
}

void fragment() {
	// Called for every pixel the material is visible on.
}

