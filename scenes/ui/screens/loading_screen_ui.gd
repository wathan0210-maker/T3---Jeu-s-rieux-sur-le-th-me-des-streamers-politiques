class_name LoadingScreenUI
extends CanvasLayer

signal loading_start

@onready var loading_rich_text_label: RichTextLabel = %LoadingRichTextLabel
@onready var main_panel: Panel = %MainPanel
var dots := 0

func _ready() -> void:
	await UiAnimationHandler.animate_from_right_to_center(main_panel)
	loading_start.emit()

func _on_loading_dots_timer_timeout() -> void:
	loading_rich_text_label.text = tr("LOADING")
	for i in range(dots):
		loading_rich_text_label.text += "."
	dots += 1
	if dots > 3:
		dots = 0


func _on_loading_timer_timeout() -> void:
	UiAnimationHandler.animate_from_center_to_left(main_panel)
