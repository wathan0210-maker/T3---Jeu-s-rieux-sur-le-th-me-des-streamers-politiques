class_name ApplicationIconUI
extends Control

@onready var texture_button: TextureButton = %TextureButton
@onready var label: Label = %Label

var application_name: String
var application_icon: Texture2D
var on_click: Callable

func _ready() -> void:
	_update_display()

func setup(p_name: String, p_icon: Texture2D, p_on_click: Callable) -> void:
	application_name = p_name
	application_icon = p_icon
	on_click = p_on_click
	_update_display()

func _update_display() -> void:
	label.text = application_name
	texture_button.texture_normal = application_icon

func _on_texture_button_pressed() -> void:
	if application_name and on_click.is_valid() :
		on_click.call()
