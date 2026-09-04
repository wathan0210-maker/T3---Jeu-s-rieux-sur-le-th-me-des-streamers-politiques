## Classe permettant d'accéder à des scènes à partir de n'importe quelle scène.
## Pratique lorsqu'on a des scènes qui peuvent se faire instancier dans d'autres scènes.
class_name SceneUtils
extends Node

const MAIN_MENU_SCREEN := preload("res://scenes/ui/screens/main_menu.tscn")
const SETTINGS_SCREEN := preload("res://scenes/ui/screens/settings.tscn")
