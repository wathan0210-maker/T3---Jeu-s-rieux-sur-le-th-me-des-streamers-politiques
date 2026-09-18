class_name ApplicationIconUI
extends Control

@onready var texture_button: TextureButton = %TextureButton ## Icone de l'appli
@onready var label: Label = %Label ## Nom de l'appli

var application_name: String
var application_icon: Texture2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = application_name
	texture_button.texture_normal = application_icon


func _on_texture_button_pressed() -> void:
	if application_name :
		print("ayoub")
