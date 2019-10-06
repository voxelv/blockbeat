extends Node
const _shape_manager_pre = preload("res://main/shape_manager.gd")
const _goal_camera_pre = preload("res://main/goal_shape/goal_camera.gd")
onready var goal_shape = find_node("goal_shape") as _shape_manager_pre
onready var player_shape = find_node("player_shape") as _shape_manager_pre
onready var goal_camera = find_node("goal_camera") as _goal_camera_pre

func _ready():
	randomize()
	player_shape.connect("cubes_changed", self, "_on_player_shape_cubes_changed")

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		next_shape()
		player_shape.set_shape(shapes_lib.NULL_SHAPE)

func _on_player_shape_cubes_changed():
	if shapes_lib.shapes_match(player_shape.cubes.keys(), goal_shape.cubes.keys()):
		next_shape()
		player_shape.set_shape(shapes_lib.NULL_SHAPE)

func next_shape():
#	var size = shapes_lib.SIZE.values()[randi() % (shapes_lib.SIZE.keys().size()-1) + 1]
	var size = shapes_lib.SIZE.FIVE
	var shape_list = shapes_lib.shapes[size]
	var shape_data = shape_list[shape_list.keys()[randi() % len(shape_list.keys())]]
	goal_shape.set_shape(shape_data)
	goal_camera.set_zoom_for_size(size)
