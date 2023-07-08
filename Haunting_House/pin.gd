extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	self.freeze = true
	$DropTimer.timeout.connect(_on_timer_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	self.freeze = false
	
	var rng = RandomNumberGenerator.new()
	
	self.rotate_x(rng.randf_range(0, 10))
	self.rotate_y(rng.randf_range(0, 10))
	self.rotate_z(rng.randf_range(0, 10))
	
	$RemoveTimer.start(2)
	$RemoveTimer.timeout.connect(_should_remove)

func _should_remove():
	self.queue_free()
