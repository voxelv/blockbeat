extends Node
const _shape_manager_pre = preload("res://main/shape_manager.gd")
const _goal_camera_pre = preload("res://main/goal_shape/goal_camera.gd")
onready var goal_shape = find_node("goal_shape") as _shape_manager_pre
onready var player_shape = find_node("player_shape") as _shape_manager_pre
onready var goal_camera = find_node("goal_camera") as _goal_camera_pre

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		var size = shapes_lib.SIZE.values()[randi() % (shapes_lib.SIZE.keys().size()-1) + 1]
		var shape_list = shapes_lib.shapes[size]
		var shape_data = shape_list[randi() % shape_list.size()]
		goal_shape.set_shape(shape_data)
		goal_camera.set_zoom_for_size(size)
