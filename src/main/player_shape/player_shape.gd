extends Spatial

var cube_pre = preload("res://main/player_shape/cube.tscn")

func _ready():
	place_cube(Vector3(1, -1, 0))
	place_cube(Vector3(1, 0, 0))
	place_cube(Vector3(1, 1, 0))
	place_cube(Vector3(0, -1, 0))
	place_cube(Vector3(0, 1, 0))
	place_cube(Vector3(-1, -1, 0))
	place_cube(Vector3(-1, 0, 0))
	place_cube(Vector3(-1, 1, 0))
	place_cube(Vector3(0, -1, 1))

func place_cube(pos:Vector3):
	var new_cube = cube_pre.instance()
	new_cube.translation = pos
	add_child(new_cube)
	new_cube.find_node("area").connect("input_event", self, "_on_cube_area_input_event", [new_cube, pos])

func _on_cube_area_input_event(camera, event, click_position, click_normal, shape_idx, cube:MeshInstance, pos:Vector3):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			print(pos)
			var cube_local_pos = cube.to_local(click_position).normalized()
			print(face_str(get_face(cube_local_pos)))

func get_face(v_normalized:Vector3):
	var face = Vector3.ZERO
	var current_best_match = -1
	for v in [Vector3.RIGHT, Vector3.LEFT, Vector3.UP, Vector3.DOWN, Vector3.FORWARD, Vector3.BACK]:
		var dot = v_normalized.dot(v)
		if dot > current_best_match:
			face = v
			current_best_match = dot
	return(face)

func face_str(v):
	if v == Vector3.LEFT:
		return("LEFT")
	elif v == Vector3.RIGHT:
		return("RIGHT")
	elif v == Vector3.UP:
		return("UP")
	elif v == Vector3.DOWN:
		return("DOWN")
	elif v == Vector3.FORWARD:
		return("FORWARD")
	elif v == Vector3.BACK:
		return("BACK")