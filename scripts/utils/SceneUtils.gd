## Classe permettant d'accéder à des scènes à partir de n'importe quelle scène.
## Pratique lorsqu'on a des scènes qui peuvent se faire instancier dans d'autres scènes.
class_name SceneUtils
extends Node

const MAIN_MENU_SCREEN := preload("res://scenes/ui/screens/main_menu.tscn")
const SETTINGS_SCREEN := preload("res://scenes/ui/screens/settings.tscn")
const DIALOG_SCREEN := preload("res://scenes/ui/screens/dialog_ui.tscn")
const COMPUTER_SCREEN := preload("res://scenes/ui/screens/computer_screen.tscn")
const LOADING_SCREEN := preload("res://scenes/ui/screens/loading_screen_ui.tscn")
const APP_WINDOW := preload("res://scenes/ui/screens/app_window.gd")
