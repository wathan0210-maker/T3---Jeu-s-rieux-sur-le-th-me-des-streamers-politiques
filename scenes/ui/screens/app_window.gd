class_name AppWindow
extends PanelContainer

@onready var title_label: Label = %TitleLabel
@onready var reduce_button: Button = %ReduceButton
@onready var close_button: Button = %CloseButton
@onready var content: Control = %Content

var app: App

func setup(app_scene: PackedScene) -> void:
	app = app_scene.instantiate() as App
	content.add_child(app)
	app.set_anchors_preset(Control.PRESET_FULL_RECT)
	title_label.text = app.app_name
	app.on_open()

func _ready() -> void:
	close_button.pressed.connect(_on_close_pressed)

func _on_close_pressed() -> void:
	app.on_close()
	queue_free()
