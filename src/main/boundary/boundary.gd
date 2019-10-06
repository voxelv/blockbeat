extends Spatial

export (String, "3", "5", "7") var side_length = "3"

var side_len:int

onready var z_borders = find_node("z_borders")
onready var y_borders = find_node("y_borders")
onready var x_borders = find_node("x_borders")

func set_side_len(side_len):
	var half_len:float = side_len / 2.0
	var m:MeshInstance
	
	m = z_borders.get_child(0)
	m.mesh.size.z = side_len
	m.translation = Vector3(-half_len, -half_len, 0)
	
	m = z_borders.get_child(1)
	m.mesh.size.z = side_len
	m.translation = Vector3(-half_len, half_len, 0)
	
	m = z_borders.get_child(2)
	m.mesh.size.z = side_len
	m.translation = Vector3(half_len, half_len, 0)
	
	m = z_borders.get_child(3)
	m.mesh.size.z = side_len
	m.translation = Vector3(half_len, -half_len, 0)
	
	m = y_borders.get_child(0)
	m.mesh.size.y = side_len
	m.translation = Vector3(-half_len, 0, -half_len)
	
	m = y_borders.get_child(1)
	m.mesh.size.y = side_len
	m.translation = Vector3(-half_len, 0, half_len)
	
	m = y_borders.get_child(2)
	m.mesh.size.y = side_len
	m.translation = Vector3(half_len, 0, half_len)
	
	m = y_borders.get_child(3)
	m.mesh.size.y = side_len
	m.translation = Vector3(half_len, 0, -half_len)
	
	m = x_borders.get_child(0)
	m.mesh.size.x = side_len
	m.translation = Vector3(0, -half_len, -half_len)
	
	m = x_borders.get_child(1)
	m.mesh.size.x = side_len
	m.translation = Vector3(0, -half_len, half_len)
	
	m = x_borders.get_child(2)
	m.mesh.size.x = side_len
	m.translation = Vector3(0, half_len, half_len)
	
	m = x_borders.get_child(3)
	m.mesh.size.x = side_len
	m.translation = Vector3(0, half_len, -half_len)

func _ready():
	set_side_len(int(side_length))
