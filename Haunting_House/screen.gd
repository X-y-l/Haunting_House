extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready():
	# RenderingServer.frame_post_draw.connect(self.on_frame_post_draw)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func on_frame_post_draw():
	var viewport: SubViewport = get_parent().get_node("SubViewport")
	
	self.get_surface_override_material(0)
	
	RenderingServer.frame_post_draw.disconnect(self.on_frame_post_draw)
