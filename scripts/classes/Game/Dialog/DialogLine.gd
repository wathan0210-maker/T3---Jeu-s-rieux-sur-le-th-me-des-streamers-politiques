class_name DialogLine
extends Resource

@export var speaker: String ## Celui qui parle
@export var text: String ## Ce qui est dit
@export var choices: Array[DialogChoice] ## (optionel) Choix
@export var event_id: int ## (optionel) Quel evenement est lancé après cette ligne de dialogue
