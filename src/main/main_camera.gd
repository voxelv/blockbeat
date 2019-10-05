extends Spatial

export (float, 0.0, 2.0) var rotation_speed = PI/2

# mouse properties
export (bool) var mouse_control = false
export (float, 0.001, 0.1) var mouse_sensitivity = 0.005
export (bool) var invert_y = false
export (bool) var invert_x = false

# zoom settings
export (float) var max_zoom = 3.0
export (float) var min_zoom = 0.4
export (float, 0.05, 1.0) var zoom_speed = 0.09

var zoom = (max_zoom - min_zoom) / 2.0 + min_zoom

func _init():
	scale = Vector3.ONE * zoom

func _process(delta):
	if !mouse_control:
		get_input_keyboard(delta)
	$inner_gimbal.rotation.x = clamp($inner_gimbal.rotation.x, deg2rad(-90), deg2rad(90))
	scale = lerp(scale, Vector3.ONE * zoom, zoom_speed)

func _unhandled_input(event):
	if Input.is_mouse_button_pressed(BUTTON_MIDDLE):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		if mouse_control and event is InputEventMouseMotion:
			if event.relative.x != 0:
				var dir = 1 if invert_x else -1
				rotate_object_local(Vector3.UP, dir * event.relative.x * mouse_sensitivity)
			if event.relative.y != 0:
				var dir = 1 if invert_y else -1
				var y_rotation = clamp(event.relative.y, -30, 30)
				$inner_gimbal.rotate_object_local(Vector3.RIGHT, dir * y_rotation * mouse_sensitivity)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if event.is_action_pressed("cam_zoom_in"):
		zoom -= zoom_speed
	if event.is_action_pressed("cam_zoom_out"):
		zoom += zoom_speed
	zoom = clamp(zoom, min_zoom, max_zoom)

func get_input_keyboard(delta):
	var y_rotation = 0
	if Input.is_action_pressed("cam_right"):
		y_rotation += 1
	if Input.is_action_pressed("cam_left"):
		y_rotation -= 1
	rotate_object_local(Vector3.UP, y_rotation * rotation_speed * delta)
	var x_rotation = 0
	if Input.is_action_pressed("cam_up"):
		x_rotation -= 1
	if Input.is_action_pressed("cam_down"):
		x_rotation += 1
	$inner_gimbal.rotate_object_local(Vector3.RIGHT, x_rotation * rotation_speed * delta)