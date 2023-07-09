extends Node3D

@export var current_node: Area3D
@export var speed: float = 0.8
@export var go_to_new_node_prob: float = 0.3
@export var go_to_new_room_prob: float = 0.2
@export var move_delay: float = 0.5

var target_position: Vector3 = Vector3.ZERO
var close_dist = 0.2
var rng = RandomNumberGenerator.new()
var spook = 0.0

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
			
			# TODO: this should only pick one which is connected to the node
			var door = room_node.get_node(doors.pick_random())
			
			target_position = door.global_position
			
			var areas = door.get_overlapping_areas()
			if areas.size() < 1:
				return
				
			var new_area = areas[0]
			
			for area in areas:
				if area == room_node:
					continue
				new_area = area
				break
				
			var nodes = new_area.get_node("Nodes").get_children()
			var connected_to_door = door.connected_nodes
			while true:
				current_node = nodes.pick_random()
				var found = false
				for conn in connected_to_door:
					if door.get_node(conn) == current_node:
						found = true
						break
				if found:
					break
		elif rng.randf() < go_to_new_node_prob:
			var nodes = current_node.connected_nodes #current_node.get_parent().get_children()
			if nodes.size() > 1:
				var new_node_path = nodes[rng.randi_range(0, nodes.size()-1)]
				var new_node = current_node.get_node(new_node_path)
				
				while new_node == current_node:
					new_node = nodes[rng.randi_range(0, nodes.size()-1)]
					
				current_node = new_node
		else:
			target_position = current_node.random_location()

func _on_move_timer_timeout():
	_update_target()
