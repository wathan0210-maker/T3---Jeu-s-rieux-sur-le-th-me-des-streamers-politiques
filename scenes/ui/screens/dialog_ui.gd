class_name DialogUI
extends CanvasLayer

const FLECHE := "⪢"

@export var dialogue_resource: DialogueResource
@export var start_from_cue: String = ""
@export var auto_start: bool = false
@export var next_action: StringName = &"game_pass_text"
@export var skip_action: StringName = &"game_skip_text"

## Maps a response's "color" tag (ex. [#color=attack]) to the color its button gets.
@export var response_colors: Dictionary[String, Color] = {
	"contre_attaque": Color(0.3, 0.55, 0.95),
	"montrer_preuve": Color(0.35, 0.75, 0.35),
	"rien_faire": Color(0.85, 0.3, 0.3),
}

@onready var speaker_name_label: Label = %SpeakerNameLabel
@onready var main_text_rich_text_label: DialogueLabel = %MainTextRichTextLabel
@onready var pass_text_label: Label = %PassTextLabel
@onready var responses_menu: DialogueResponsesMenu = %ResponsesMenu

var is_waiting_for_input := false
var is_waiting_for_response := false
var temporary_game_states: Array = []

var dialogue_line: DialogueLine:
	set(value):
		if value:
			dialogue_line = value
			apply_dialogue_line()
		else: # Dialog fini
			hide()
	get:
		return dialogue_line

func _ready() -> void:
	hide()
	main_text_rich_text_label.skip_action = skip_action
	responses_menu.next_action = next_action
	responses_menu.response_selected.connect(_on_responses_menu_response_selected)
	if auto_start and is_instance_valid(dialogue_resource):
		start()

func _unhandled_input(event: InputEvent) -> void:
	if not visible or not is_instance_valid(dialogue_line):
		return
	
	if main_text_rich_text_label.is_typing:
		if event.is_action_pressed(skip_action) or event.is_action_pressed(next_action):
			get_viewport().set_input_as_handled()
			main_text_rich_text_label.skip_typing()
		return
	
	if dialogue_line.responses.size() > 0:
		return
	
	if is_waiting_for_input and event.is_action_pressed(next_action):
		get_viewport().set_input_as_handled()
		next(dialogue_line.next_id)

func _process(delta: float) -> void:
	if !is_waiting_for_response and Input.is_action_pressed(skip_action):
		if !is_waiting_for_input:
			main_text_rich_text_label.skip_typing()
		else:
			get_viewport().set_input_as_handled()
			next(dialogue_line.next_id)

## Start some dialogue
func start(with_dialogue_resource: DialogueResource = null, cue: String = "", extra_game_states: Array = []) -> void:
	temporary_game_states = [self] + extra_game_states
	is_waiting_for_input = false
	if is_instance_valid(with_dialogue_resource):
		dialogue_resource = with_dialogue_resource
	if not cue.is_empty():
		start_from_cue = cue
	dialogue_line = await dialogue_resource.get_next_dialogue_line(start_from_cue, temporary_game_states)

## Apply any changes to the balloon given a new [DialogueLine].
func apply_dialogue_line() -> void:
	is_waiting_for_input = false
	pass_text_label.text = "   "
	responses_menu.hide()
	show()
	
	speaker_name_label.visible = not dialogue_line.character.is_empty()
	speaker_name_label.text = tr(dialogue_line.character, "dialogue")
	
	main_text_rich_text_label.dialogue_line = dialogue_line
	if not dialogue_line.text.is_empty():
		main_text_rich_text_label.type_out()
		await main_text_rich_text_label.finished_typing
	
	if dialogue_line.responses.size() > 0:
		responses_menu.responses = dialogue_line.responses
		_style_responses()
		responses_menu.show()
	else:
		is_waiting_for_input = true
		pass_text_label.text = FLECHE

## Tint each response button by its "color" tag, if it has one.
func _style_responses() -> void:
	var get_focus := false
	for item: Control in responses_menu.get_children():
		var response: DialogueResponse = item.get_meta(&"response", null)
		if !get_focus:
			item.grab_focus()
			get_focus = true
		if response == null:
			continue
		item.modulate = response_colors.get(response.get_tag_value("color"), Color.WHITE)
	is_waiting_for_response = true

## Go to the next line
func next(next_id: String) -> void:
	dialogue_line = await dialogue_resource.get_next_dialogue_line(next_id, temporary_game_states)

func _on_responses_menu_response_selected(response: DialogueResponse) -> void:
	next(response.next_id)
