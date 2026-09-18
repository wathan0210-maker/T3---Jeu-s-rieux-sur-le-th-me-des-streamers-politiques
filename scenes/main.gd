class_name Main
extends Node

var current_scene: Node:
	set(value):
		if current_scene:
			current_scene.queue_free()
		current_scene = value
		add_child(current_scene)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameGlobal.main = self
	
	# Commencer sur le menu principal
	current_scene = SceneUtils.MAIN_MENU_SCREEN.instantiate()
