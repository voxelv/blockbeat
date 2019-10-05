extends Node
const _shape_manager_pre = preload("res://main/shape_manager.gd")
onready var goal_shape = find_node("goal_shape") as _shape_manager_pre
onready var player_shape = find_node("player_shape") as _shape_manager_pre

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		print("ui_accept")
		pass
