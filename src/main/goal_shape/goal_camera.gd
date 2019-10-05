extends Spatial

export (float, 0.0, 2.0) var rotation_speed = PI/2

# zoom settings
export (float) var max_zoom = 3.0
export (float) var min_zoom = 0.4
export (float, 0.05, 1.0) var zoom_speed = 0.2

var zoom = (max_zoom - min_zoom) / 2.0 + min_zoom

var time_acc = 0

func set_zoom(z:float):
	zoom = z
	zoom = clamp(zoom, min_zoom, max_zoom)

func _process(delta):
	rotate_object_local(Vector3.UP, rotation_speed * delta)
	
	time_acc += delta
	scale = lerp(scale, Vector3.ONE * zoom, zoom_speed)
	
	$inner_gimbal.rotation.x = sin(time_acc)

func _on_increase_zoom_button_pressed():
	set_zoom(zoom - zoom_speed)

func _on_decrease_zoom_button_pressed():
	set_zoom(zoom + zoom_speed)

func set_zoom_for_size(size:int):
	set_zoom({shapes_lib.SIZE.THREE: 0.9, shapes_lib.SIZE.FIVE: 1.5, shapes_lib.SIZE.SEVEN: 2.2}[size])
