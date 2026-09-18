class_name ComputerScreenUI
extends CanvasLayer

const APPLICATION_ICON_SCREEN := preload("res://scenes/shared/application_icon.tscn")

@onready var computer_grid_container: GridContainer = %ComputerGridContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# Internet app
	var internet_app: ApplicationIconUI = APPLICATION_ICON_SCREEN.instantiate()
	internet_app.application_name = "Internet"
	internet_app.application_icon = preload("res://assets/icons/Apps/internet_icon.png")
	computer_grid_container.add_child(internet_app)
	
	# Dossier app
	var dossiers_app: ApplicationIconUI = APPLICATION_ICON_SCREEN.instantiate()
	dossiers_app.application_name = "Dossiers"
	dossiers_app.application_icon = preload("res://assets/icons/Apps/dossiers_icon.png") # tkt
	computer_grid_container.add_child(dossiers_app)
	
	# Mails app
	var mails_app: ApplicationIconUI = APPLICATION_ICON_SCREEN.instantiate()
	mails_app.application_name = "Mails"
	mails_app.application_icon = preload("res://assets/icons/Apps/mails_icon.png") # tkt
	computer_grid_container.add_child(mails_app)
	
	# Notes app
	var notes_app: ApplicationIconUI = APPLICATION_ICON_SCREEN.instantiate()
	notes_app.application_name = "Notes"
	notes_app.application_icon = preload("res://assets/icons/Apps/notes_icon.png") # tkt
	computer_grid_container.add_child(notes_app)
	
	# no app
	var no_app: ApplicationIconUI
	for i in range(27):
		no_app = APPLICATION_ICON_SCREEN.instantiate()
		no_app.application_name = ""
		no_app.application_icon = null # tkt
		computer_grid_container.add_child(no_app)
		
	# OBS app
	var obs_app: ApplicationIconUI = APPLICATION_ICON_SCREEN.instantiate()
	obs_app.application_name = "Lancer le live"
	obs_app.application_icon = preload("res://assets/icons/Apps/OBS_Studio_logo.png")
	computer_grid_container.add_child(obs_app)
	
	# OBS app
	#var obs_application_icon: ApplicationIconUI = %OBSApplicationIcon
	#obs_application_icon.application_name = "Lancer le live"
	#obs_application_icon.application_icon = preload("res://assets/icons/Apps/OBS_Studio_logo.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
