class_name Main
extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Commencer sur le menu principal
	var main_menu_window := SceneUtils.MAIN_MENU_SCREEN.instantiate()
	add_child(main_menu_window)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
