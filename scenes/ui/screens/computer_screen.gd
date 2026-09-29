class_name ComputerScreenUI
extends CanvasLayer

const APPLICATION_ICON_SCREEN := preload("res://scenes/shared/application_icon.tscn")
@onready var computer_grid_container: GridContainer = %ComputerGridContainer

func _on_click_generic() -> void :
	print("Ayouuuuub (eurw)")

func _on_click_settings() -> void :
	add_child(SceneUtils.SETTINGS_SCREEN.instantiate())

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var internet_app: ApplicationIconUI = APPLICATION_ICON_SCREEN.instantiate()
	computer_grid_container.add_child(internet_app)
	internet_app.setup("Internet", preload("res://assets/icons/Apps/internet_icon.png"), _on_click_generic)

	var dossiers_app: ApplicationIconUI = APPLICATION_ICON_SCREEN.instantiate()
	computer_grid_container.add_child(dossiers_app)
	dossiers_app.setup("Dossiers", preload("res://assets/icons/Apps/dossiers_icon.png"), _on_click_generic)

	var mails_app: ApplicationIconUI = APPLICATION_ICON_SCREEN.instantiate()
	computer_grid_container.add_child(mails_app)
	mails_app.setup("Mails", preload("res://assets/icons/Apps/mails_icon.png"), _on_click_generic)

	var notes_app: ApplicationIconUI = APPLICATION_ICON_SCREEN.instantiate()
	computer_grid_container.add_child(notes_app)
	notes_app.setup("Notes", preload("res://assets/icons/Apps/notes_icon.png"), _on_click_generic)
	
	var settings_app: ApplicationIconUI = APPLICATION_ICON_SCREEN.instantiate()
	computer_grid_container.add_child(settings_app)
	settings_app.setup("Paramètres", preload("res://assets/icons/Apps/settings.png"), _on_click_settings)
	
	var wallpapers_app: ApplicationIconUI = APPLICATION_ICON_SCREEN.instantiate()
	computer_grid_container.add_child(wallpapers_app)
	wallpapers_app.setup("Fond d'écrans", preload("res://assets/icons/Apps/wallpapers_icon.png"), _on_click_generic)

	var obs_application_icon: ApplicationIconUI = %OBSApplicationIcon
	obs_application_icon.setup("Lancer le live", preload("res://assets/icons/Apps/OBS_Studio_logo.png"), _on_click_generic)
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
