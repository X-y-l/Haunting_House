extends RigidBody3D

signal on_placed(area)

var placed: bool = false
@export var drop_time: float = 5
var reset_position = null
var reset_rotation = null

# Called when the node enters the scene tree for the first time.
func _ready():
	reset_position = self.global_position
	reset_rotation = self.global_rotation + Vector3(0,3.14159,0)
	self.freeze = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	drop()

func _should_remove():
	self.global_position = reset_position
	self.global_rotation = reset_rotation
	self.freeze = true
	self.placed = false

func place(object):
	if placed:
		return

	self.freeze = true
	self.placed = true
	$DropTimer.start(drop_time)
	
	var room_area_path = object.get_meta("room_area")
	var room_area = object.get_node(room_area_path)
	
	print("placed for ", drop_time, " seconds in ", object, " which corresponds to ", room_area)
	emit_signal("on_placed", room_area)

func drop():
	self.freeze = false
	
	var rng = RandomNumberGenerator.new()
	
	self.apply_torque(Vector3(
		rng.randf_range(-0.3, 0.3),
		rng.randf_range(-0.3, 0.3),
		rng.randf_range(-0.3, 0.3),
	))
	
	$RemoveTimer.start(2)


func _on_body_entered(body):
	$AudioStreamPlayer.play()
