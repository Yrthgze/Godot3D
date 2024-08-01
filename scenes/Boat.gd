extends RigidBody3D

@export var float_force := 1.0
@export var water_drag := 0.05
@export var water_angular_drag := 0.05
@onready var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var water = get_node("/root/Level1/Sea/SeaMesh")
const water_height := 0.0
var submerged := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _physics_process(_delta):
	submerged = false
	var water_height= water.get_height(global_position)
	var cube_height = global_position.y
	if water_height > 0:
		pass
	var depth = water.get_height(global_position) - global_position.y
	if depth > 0 :
		submerged = true
		apply_central_force(Vector3.UP * float_force * gravity * depth)
		

func _integrate_forces(state):
	if submerged:
		state.linear_velocity *= 1 - water_drag
		state.angular_velocity *= 1 - water_angular_drag
