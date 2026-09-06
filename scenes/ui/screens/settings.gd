class_name SettingsUI
extends CanvasLayer

# Autres
@onready var save_cooldown_timer: Timer = %SaveCooldownTimer ## Cooldown pour sauvegarder
@onready var status_label: Label = %StatusLabel ## Status de sauvegarde des paramètres

# Controls pour les paramètres
@onready var principal_h_slider: HSlider = %PrincipalHSlider
@onready var musique_h_slider: HSlider = %MusiqueHSlider
@onready var effets_h_slider: HSlider = %EffetsHSlider
@onready var voix_h_slider: HSlider = %VoixHSlider
@onready var fullscreen_check_button: CheckButton = %FullscreenCheckButton
@onready var resolution_option_button: OptionButton = %ResolutionOptionButton
@onready var vitesse_dialogues_buttons: HBoxContainer = %VitesseDialoguesButtons
@onready var langage_buttons: HBoxContainer = %LangageButtons

# Variables, Constantes, ect...
const DEFAULT_SETTINGS: Dictionary[String, Dictionary] = {
	"sound" : {
		"master" : 50,
		"music" : 50,
		"effect" : 50,
		"voice" : 50,
	},
	"screen" : {
		"fullscreen" : false,
		"resolution" : "1366x768"
	},
	"game" : {
		"dialog_speed" : 1, # 0 (lent), 1 (moyen), 2 (rapide)
		"language" : "fr"
	},
}

const RESOLUTIONS: Array[String] = [
"1920x1200", "1920x1080", 
"1600x900", "1536x864", "1440x900", 
"1366x768", "1280x1024", "1280x720",
]

# Script
func _ready() -> void:
	for res: String in RESOLUTIONS:
		resolution_option_button.add_item(res)
	
	# (Ajouter une vérification pour voir si le joueur a déjà des paramètres)
	load_settings(DEFAULT_SETTINGS)

## Sauvegarde les paramètres dans le fichier de paramètres.
func save_settings() -> void:
	status_label.text = "Erreur lors de la sauvegarde des paramètres!"

## Charge les paramètres du joueur dans l'interface
func load_settings(settings_dict: Dictionary[String, Dictionary]) -> void:
	# Son
	principal_h_slider.value = settings_dict["sound"]["master"]
	musique_h_slider.value = settings_dict["sound"]["music"]
	effets_h_slider.value = settings_dict["sound"]["effect"]
	voix_h_slider.value = settings_dict["sound"]["voice"]
	# Affichage
	fullscreen_check_button.button_pressed = settings_dict["screen"]["fullscreen"]
	resolution_option_button.select(RESOLUTIONS.find(settings_dict["screen"]["resolution"]))
	# Jeu
	vitesse_dialogues_buttons.get_children()[settings_dict["game"]["dialog_speed"]].button_pressed = true
	for child: Button in langage_buttons.get_children():
		if child.name == settings_dict["game"]["language"]:
			child.button_pressed = true

# === Appliquer les paramètres lorsqu'un changement est effectué ===
## Pour tous les Slider
func _on_slider_value_changed(value: float) -> void:
	apply_settings("SOUND")

## Pour tous les Button
func _on_button_pressed() -> void:
	apply_settings("SCREEN")

## Pour les OptionButton
func _on_option_button_item_selected(index: int) -> void:
	apply_settings()

## Appliquer les changements
## - setting, String (flag) = "ALL" pour tous les paramètres
## "SOUND" pour seulement les paramètres de son
## "SCREEN" pour seulement les paramètres d'écran
## "GAME" pour seulement les paramètres de jeu
func apply_settings(setting:="ALL") -> void:
	status_label.text = ""
	
	if setting == "SCREEN" or setting == "ALL":
		# Plein écran
		if fullscreen_check_button.button_pressed and DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			resolution_option_button.disabled = true
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			resolution_option_button.disabled = false
	
		# Résolution
		var res := resolution_option_button.text.split("x")
		var vec_res := Vector2i(int(res[0]), int(res[1]))
		if DisplayServer.window_get_size() != vec_res:
			DisplayServer.window_set_min_size(Vector2i.ZERO)
			DisplayServer.window_set_max_size(Vector2i.ZERO)
			DisplayServer.window_set_size(vec_res)
			DisplayServer.window_set_max_size(vec_res)
			DisplayServer.window_set_min_size(vec_res)
	
	if setting == "SOUND" or setting == "ALL":
		# Sons (à faire plus tard)
		pass
	
	if setting == "GAME" or setting == "ALL":
		# Jeu (à faire plus tard)
		pass
	
	save_cooldown_timer.start()

func _on_save_cooldown_timer_timeout() -> void:
	save_settings()

func _on_back_button_pressed() -> void:
	save_settings()
	queue_free()

func _on_reset_button_pressed() -> void:
	load_settings(DEFAULT_SETTINGS)
