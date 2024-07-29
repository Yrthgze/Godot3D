shader_type spatial;

void vertex() {
	// Called for every vertex the material is visible on.
	VERTEX.x += VERTEX.x * 3.0;
}

void fragment() {
	if(UV.x > 0.5 ){
		ALBEDO = vec3(0,0.2,1);
	}
	else
	{
		ALBEDO = vec3(1,0.2,1);
	}
	
	ROUGHNESS = 0.2;
	RIM = 1.0;
}
//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
