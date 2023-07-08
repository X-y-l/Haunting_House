extends RigidBody3D

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
	print("placed for ", drop_time, " seconds in ", object)

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
