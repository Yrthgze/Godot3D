extends MeshInstance3D

var material: ShaderMaterial
var wave_speed: float
var height_scale: float
var time: float

# Called when the node enters the scene tree for the first time.
func _ready():
	material = mesh.surface_get_material(0)
	wave_speed = material.get_shader_parameter("speed")
	height_scale = material.get_shader_parameter("amount")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	material.set_shader_parameter("wave_time", time)

func generate_offset(x:float, z: float, val1: float, val2: float, f_time: float):
	var radiansX = ((fmod(x + z * x * val1, height_scale) / height_scale) + (f_time * wave_speed) * fmod(x * 0.8 + z, 1.5)) * TAU;
	var radiansZ = ((fmod(val2 * (z * x + x * z), height_scale) / height_scale) + (f_time * wave_speed) * 2.0 * fmod(x, 2.0)) * TAU;
	return height_scale * 0.5 * (sin(radiansZ) * cos(radiansX));

func apply_distortion(vertex: Vector3, f_time: float):
	var xd = generate_offset(vertex.x, vertex.z, 0.2, 0.1, f_time);
	var yd = generate_offset(vertex.x, vertex.z, 0.1, 0.3, f_time);
	var zd = generate_offset(vertex.x, vertex.z, 0.15, 0.2, f_time);
	return vertex + Vector3(xd, yd, zd);
	

func get_height(world_position: Vector3) -> float:
	var height:Vector3 = apply_distortion(world_position, time);
	return height.y
