class_name App
extends Control

@export var app_name: String = "Sans nom"
@export var app_icon: Texture2D = preload("res://assets/icons/icon.svg")

# Appelées par le wrapper
func on_open() -> void:
	pass

func on_close() -> void:
	pass
