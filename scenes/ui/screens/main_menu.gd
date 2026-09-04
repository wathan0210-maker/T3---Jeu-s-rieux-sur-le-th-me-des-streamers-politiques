class_name MainMenuUI
extends CanvasLayer


func _on_start_button_pressed() -> void:
	pass # Replace with function body.


func _on_settings_button_pressed() -> void:
	pass # Replace with function body.


func _on_credits_button_pressed() -> void:
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().root.queue_free() # On supprime le root pour quitter le jeu
