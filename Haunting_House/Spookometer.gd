extends Node3D

const left = -55
const right = 200
var target = left

func setspook(spook):
	target = left + spook * (right - left)

func _ready():
	setspook(0.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$CSGCylinder3D.rotation_degrees = $CSGCylinder3D.rotation_degrees.lerp(Vector3(target,90,90),delta*4)
	#$CSGCylinder3D.rotation.x
#304,343
# -55 to 200
