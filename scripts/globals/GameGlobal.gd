# GameGlobal
extends Node

var main: Main
var is_scene_loader_busy := false

func load_scene(new_scene: PackedScene) -> void:
	if !main:
		return
	if !is_scene_loader_busy:
		is_scene_loader_busy = true
		var loading_screen_instance: LoadingScreenUI = SceneUtils.LOADING_SCREEN.instantiate()
		main.add_child(loading_screen_instance)
		await loading_screen_instance.loading_start
		main.current_scene = new_scene.instantiate()
		is_scene_loader_busy = false
