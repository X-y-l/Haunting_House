extends Node3D

@export var current_node: Area3D
@export var speed: float = 0.8
@export var go_to_new_node_prob: float = 0.3
@export var go_to_new_room_prob: float = 0.2
@export var move_delay: float = 0.5

var target_position: Vector3 = Vector3.ZERO
var close_dist = 0.2
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	_update_target()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target_position != Vector3.ZERO:
		var diff = target_position - self.global_position
		
		if diff.length_squared() < close_dist*close_dist:
			target_position = Vector3.ZERO
		else:
			self.global_position += diff.normalized() * delta * speed
	elif $MoveTimer.is_stopped():
		$MoveTimer.start(move_delay)

func _update_target():
	if current_node != null:
		if rng.randf() < go_to_new_room_prob:
			var room_node = current_node.get_parent().get_parent()
			var doors = room_node.doors
			var door = room_node.get_node(doors[rng.randi_range(0, doors.size()-1)])
			print("moving to new room: ", door)
			target_position = door.global_position
			var areas = door.get_overlapping_areas()
			for area in areas:
				if area != room_node:
					var nodes = area.get_node("Nodes").get_children()
					current_node = nodes[rng.randi_range(0, nodes.size() - 1)]
					print("going to area: ", area, "; node = ", current_node)
		elif rng.randf() < go_to_new_node_prob:
			var nodes = current_node.get_parent().get_children()
			if nodes.size() > 1:
				var new_node = nodes[rng.randi_range(0, nodes.size()-1)]
				
				while new_node == current_node:
					new_node = nodes[rng.randi_range(0, nodes.size()-1)]
					
				current_node = new_node
				print("went to new node")
		else:
			target_position = current_node.random_location()
			print("went to new position in current node")

func _on_move_timer_timeout():
	_update_target()
