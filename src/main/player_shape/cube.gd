extends MeshInstance

var coord:Array = [0, 0, 0]

func set_coord_v(v:Vector3):
	coord[0] = int(v.x)
	coord[1] = int(v.y)
	coord[2] = int(v.z)
	translation = Vector3(coord[0], coord[1], coord[2])
