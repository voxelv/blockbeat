extends Node
const _shape_manager_pre = preload("res://main/shape_manager.gd")
const _goal_camera_pre = preload("res://main/goal_shape/goal_camera.gd")
const _boundary_pre = preload("res://main/boundary/boundary.gd")
onready var goal_shape = find_node("goal_shape") as _shape_manager_pre
onready var player_shape = find_node("player_shape") as _shape_manager_pre
onready var goal_camera = find_node("goal_camera") as _goal_camera_pre
onready var boundary = find_node("boundary") as _boundary_pre
onready var animation = find_node("animation") as AnimationPlayer

var size_to_set = shapes_lib.SIZE.THREE

func _ready():
	randomize()
	animation.connect("animation_finished", self, "_on_animation_finished")
	animation.play("goal_cam_up")
	next_shape()
	player_shape.connect("cubes_changed", self, "_on_player_shape_cubes_changed")

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		next_shape()

func _on_player_shape_cubes_changed():
	if shapes_lib.shapes_match(player_shape.cubes.keys(), goal_shape.cubes.keys()):
		next_shape()
		player_shape.set_shape(shapes_lib.NULL_SHAPE)

func next_shape():
	player_shape.disable_input()
	animation.play("goal_cam_down")
#	boundary.set_side_len({shapes_lib.SIZE.THREE:3, shapes_lib.SIZE.FIVE:5, shapes_lib.SIZE.SEVEN:7}[size])

func _on_animation_finished(anim_name:String):
	if anim_name == "goal_cam_down":
		var size = shapes_lib.SIZE.values()[randi() % (shapes_lib.SIZE.keys().size()-1) + 1]
		var shape_list = shapes_lib.shapes[size]
		var shape_data = shape_list[shape_list.keys()[randi() % len(shape_list.keys())]]
		animation.play("goal_cam_up")
		goal_shape.set_shape(shape_data)
		size_to_set = size
	elif anim_name == "goal_cam_up":
		goal_camera.set_zoom_for_size(size_to_set)
		player_shape.enable_input()
