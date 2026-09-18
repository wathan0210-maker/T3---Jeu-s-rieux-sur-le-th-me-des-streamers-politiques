class_name DialogSequence
extends Resource

@export var dialog: Array[DialogLine]

func read_line(line: int) -> DialogLine:
	if line > dialog.size():
		return null
	return dialog[line-1]
