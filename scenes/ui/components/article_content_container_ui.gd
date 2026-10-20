class_name ArticleContentContainerUI
extends ScrollContainer

@onready var logo_texture_rect: TextureRect = %LogoTextureRect
@onready var bar_color_rect: ColorRect = %BarColorRect
@onready var title_label: Label = %TitleLabel
@onready var content_rich_text_label: RichTextLabel = %ContentRichTextLabel

var article: Article:
	set(value):
		article = value
		await ready
		if article:
			if article.media:
				logo_texture_rect.texture = article.media.icon
				bar_color_rect.color = article.media.color
				theme.default_font = article.media.specific_font
			title_label.text = article.title
			content_rich_text_label.text = article.content
