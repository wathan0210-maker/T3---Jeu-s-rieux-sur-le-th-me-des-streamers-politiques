class_name Article
extends Resource

@export_group("Article Info")
@export var title: String
@export var subtitle: String
@export_multiline var content: String
@export var good_clues : Array[String]
@export var image: Texture2D ## Optional
@export var media: Media
@export var is_good_article: bool

var was_opened: bool
