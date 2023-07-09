extends Area3D

@export var doors: Array = []
@export var board_area: Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	# Considering "area" an Area3D, and layer 32 an unused layer
	self.set_collision_layer_value(32, not self.get_collision_layer_value(32))
