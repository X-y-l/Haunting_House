extends Camera3D

var mid_rot: float
var time: float = 0

@export var move_speed = 0.3
@export var move_amount = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	mid_rot = self.rotation.y
	time = hash(self.name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	self.rotation.y = mid_rot + (sin(time * move_speed) - 0.5) * move_amount * 2
