extends OmniLight3D

@onready var timer := $LightTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_light_timer_timeout():
	var rand_amt := (randf())
	rand_amt *= rand_amt
	print(rand_amt)
	self.light_energy = 3 - rand_amt
	timer.start(rand_amt/2)
