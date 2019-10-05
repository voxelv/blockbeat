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
			var cube_local_pos = cube.to_local(click_position)
			print(cube_local_pos)
