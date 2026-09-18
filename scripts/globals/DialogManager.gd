extends Node

signal start_dialog

var dialog_sequence: DialogSequence:
	set(value):
		dialog_sequence = value
		line = 0
		start_dialog.emit()
var line: int = 0
var history: Dictionary[String, String]
var autoplay_on: bool = false

func pass_text() -> DialogLine:
	line+=1
	return dialog_sequence.read_line(line)
