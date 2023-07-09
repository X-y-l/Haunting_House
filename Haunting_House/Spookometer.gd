extends Node3D

const left = -55
const right = 200

func setspook(spook):
	$CSGCylinder3D.rotation_degrees.x = left + spook * (right - left)

func _ready():
	setspook(0.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#$CSGCylinder3D.rotation.x
#304,343
# -55 to 200
