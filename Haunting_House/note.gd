extends Node3D

func makenote(tint, title, body):
	$CSGBox3D/Text.text = body
	$CSGBox3D/Title.text = title
	$CSGBox3D.material.albedo_color = tint

# Called when the node enters the scene tree for the first time.
func _ready():
	makenote(Color(0, 0.5, 1, 1),"Bruce Waterman", "- Crotchety young man who smells like a butt
- Despises the youth")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

