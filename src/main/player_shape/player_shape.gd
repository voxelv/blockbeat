extends "res://main/shape_manager.gd"

func _process(delta):
	if Input.is_action_just_pressed("show_shape"):
		var s = ""
		for i in range(len(cubes.keys())):
			if i > 0:
				s += ","
			s += str(cubes.keys()[i])
		print(s)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if !event.pressed:
				if get_child_count() <= 0:
					var pos = Vector3.ZERO
					var new_cube = place_cube(pos)
					register_cube_click_signal(new_cube, pos)

func _on_cube_area_input_event(camera, event, click_position, click_normal, shape_idx, cube:Spatial, pos:Vector3):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				var cube_local_pos = cube.to_local(click_position).normalized()
				var face = get_face(cube_local_pos)
				var new_cube_pos = cube.translation + face
				var new_cube = place_cube(new_cube_pos)
				register_cube_click_signal(new_cube, new_cube_pos)
		elif event.button_index == BUTTON_RIGHT:
			if !event.pressed:
				remove_cube(cube, null)

func register_cube_click_signal(new_cube:Spatial, pos:Vector3):
	if new_cube:
		new_cube.find_node("area").connect("input_event", self, "_on_cube_area_input_event", [new_cube, pos])