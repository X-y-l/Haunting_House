extends Node3D

# saves the central facing direction for the camera to rotate around
var middle_rot: Vector2

# the maximum rotation in each axis (x and y) in radians
var max_rotation: Vector2 = Vector2(0.1, 0.3)

# Called when the node enters the scene tree for the first time.
func _ready():
	middle_rot = Vector2(rotation.x, rotation.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var viewport = get_viewport()
	var rect = viewport.get_visible_rect()
	var mouse = viewport.get_mouse_position()
	
	mouse.x = clamp(mouse.x, 0, rect.size.x)
	mouse.y = clamp(mouse.y, 0, rect.size.y)
	
	var p = (2 * mouse / rect.size) - Vector2(1, 1)
	
	rotation.y = middle_rot.y - p.x * max_rotation.y
	rotation.x = middle_rot.x - p.y * max_rotation.x
