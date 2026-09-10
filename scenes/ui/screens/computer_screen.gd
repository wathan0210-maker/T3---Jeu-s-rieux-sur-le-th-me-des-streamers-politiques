class_name ComputerScreenUI
extends CanvasLayer

const APPLICATION_ICON_SCREEN := preload("res://scenes/shared/application_icon.tscn")

@onready var computer_grid_container: GridContainer = %ComputerGridContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var instance: ApplicationIconUI = APPLICATION_ICON_SCREEN.instantiate()
	instance.application_name = "nom de l'appli"
	instance.application_icon = preload("uid://20kyotgj0sw4") # tkt
	computer_grid_container.add_child(instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
