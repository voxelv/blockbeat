extends Spatial

var cube_pre = preload("res://main/player_shape/cube.tscn")

var cubes = {}

func place_cube(pos:Vector3):
	var new_cube = cube_pre.instance()
	new_cube.set_coord_v(pos)
	
	if not new_cube.coord in cubes.keys():
		add_child(new_cube)
		cubes[new_cube.coord] = new_cube
		return(new_cube)
	else:
		new_cube.free()
		return(null)

func remove_cube(cube:Spatial, pos):
	var key = null
	if pos:
		key = [int(pos.x), int(pos.y), int(pos.z)]
	
	if cube:
		var delete_cube = cubes[cube.coord]
		cubes.erase(cube.coord)
		delete_cube.queue_free()
	elif key and key in cubes.keys():
		var delete_cube = cubes[key] as Spatial
		cubes.erase(key)
		delete_cube.queue_free()

func get_face(v_normalized:Vector3):
	var face = Vector3.ZERO
	var current_best_match = -1
	for v in [Vector3.RIGHT, Vector3.LEFT, Vector3.UP, Vector3.DOWN, Vector3.FORWARD, Vector3.BACK]:
		var dot = v_normalized.dot(v)
		if dot > current_best_match:
			face = v
			current_best_match = dot
	return(face)

func set_shape(shape_data):
	for v in shape_data:
		pass