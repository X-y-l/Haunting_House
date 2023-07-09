extends Area3D

@export var connected_nodes: Array
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func random_location():
	var shape = $CollisionShape3D
	var cylinder = shape.shape
	var dist = rng.randf_range(0, cylinder.radius)
	var angle = rng.randf_range(0, PI * 2)
	return shape.global_position + Vector3(dist * cos(angle), 0, dist * sin(angle))
