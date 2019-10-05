extends "res://main/shape_manager.gd"

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if !event.pressed:
				if get_child_count() <= 0:
					place_cube(self, Vector3.ZERO)

func _on_cube_area_input_event(camera, event, click_position, click_normal, shape_idx, cube:Spatial, pos:Vector3):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				var cube_local_pos = cube.to_local(click_position).normalized()
				var face = get_face(cube_local_pos)
				place_cube(cube, face)
		elif event.button_index == BUTTON_RIGHT:
			if !event.pressed:
				remove_cube(cube, null)
