class_name DialogUI
extends CanvasLayer

const FLECHE := "⪢"

@onready var speaker_name_label: Label = %SpeakerNameLabel
@onready var main_text_rich_text_label: RichTextLabel = %MainTextRichTextLabel
@onready var pass_text_label: Label = %PassTextLabel

var is_text_reading := false
var text_tween: Tween

func _ready() -> void:
	hide()
	DialogManager.start_dialog.connect(pass_text)
	DialogManager.dialog_sequence = preload("res://scripts/resources/DialogSequences/testdialog.tres")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("game_pass_text"):
		if text_tween != null:
			if text_tween.is_running():
				text_tween.kill()
				main_text_rich_text_label.visible_ratio = 1
			else:
				pass_text()

func show_text(speaker: String, text: String) -> void:
	#print("reading " + text + "\nfrom " + speaker)
	pass_text_label.text = ""
	show()
	speaker_name_label.text = speaker
	main_text_rich_text_label.text = text
	text_tween = get_tree().create_tween()
	main_text_rich_text_label.visible_ratio = 0
	text_tween.tween_property(main_text_rich_text_label, "visible_ratio", 1, 1.0)
	await text_tween.finished
	text_tween.kill()
	pass_text_label.text = FLECHE

func pass_text() -> void:
	var dialog_line: DialogLine = DialogManager.pass_text()
	if dialog_line != null:
		show_text(dialog_line.speaker, dialog_line.text)
	else: # Dialog fini
		hide()
