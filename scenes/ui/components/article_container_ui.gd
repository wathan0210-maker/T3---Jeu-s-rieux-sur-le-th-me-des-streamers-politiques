class_name ArticleContainerUI
extends VBoxContainer

@onready var logo_texture_rect: TextureRect = %LogoTextureRect
@onready var media_name_label: Label = %MediaNameLabel
@onready var title_link_button: LinkButton = %TitleLinkButton
@onready var subtitle_label: RichTextLabel = %SubtitleLabel

var article: Article:
	set(value):
		article = value
		await ready
		if article:
			if article.media:
				logo_texture_rect.texture = article.media.icon
				media_name_label.text = article.media.media_name
			title_link_button.text = article.title
			subtitle_label.text = article.subtitle
