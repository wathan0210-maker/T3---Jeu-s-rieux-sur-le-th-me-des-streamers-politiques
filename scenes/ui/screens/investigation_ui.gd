extends CanvasLayer

var article_container_ui_scene := preload("uid://dcfc3xa8cwbil")
var article_content_container_ui_scene := preload("uid://dt6cnth0hibtc")

@onready var googole_container: MarginContainer = %GoogoleContainer
@onready var reasearch_container: VBoxContainer = %ReasearchContainer
@onready var article_container: MarginContainer = %ArticleContainer
@onready var recommendations_v_box_container: VBoxContainer = %RecommendationsVBoxContainer
@onready var articles_v_box_container: VBoxContainer = %ArticlesVBoxContainer
@onready var searchbar_line_edit: LineEdit = %SearchbarLineEdit

enum WINDOW_TYPE {
	DEFAULT,
	SEARCH,
	IN_ARTICLE,
}

var current_window_type: WINDOW_TYPE:
	set(value):
		current_window_type = value
		match current_window_type:
			WINDOW_TYPE.DEFAULT:
				googole_container.show()
				reasearch_container.hide()
				article_container.hide()
			WINDOW_TYPE.SEARCH:
				reasearch_container.show()
				article_container.hide()
				googole_container.hide()
			WINDOW_TYPE.IN_ARTICLE:
				article_container.show()
				googole_container.hide()
				reasearch_container.hide()
			_: # Default
				current_window_type = WINDOW_TYPE.DEFAULT

var current_investigation: Investigation
var current_recommendation: Recommendation
var current_article: Article

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_main_window()

func load_main_window() -> void:
	if !GameGlobal.current_investigation:
		return
	# Setup window
	current_window_type = WINDOW_TYPE.DEFAULT
	
	current_investigation = GameGlobal.current_investigation
	searchbar_line_edit.text = ""
	# Cleanup before instantiating recomendations
	for child: Node in recommendations_v_box_container.get_children():
		child.queue_free()
	# Adding recommendations
	for recommendation: Recommendation in current_investigation.recommendations:
		var link_button := LinkButton.new()
		link_button.text = recommendation.title
		link_button.pressed.connect(go_to_recommendation.bind(recommendation))
		recommendations_v_box_container.add_child(link_button)

func go_to_recommendation(recommendation: Recommendation) -> void:
	searchbar_line_edit.text = recommendation.title
	current_window_type = WINDOW_TYPE.SEARCH
	current_recommendation = recommendation
	for child: Node in articles_v_box_container.get_children():
		child.queue_free()
	
	for article: Article in recommendation.articles:
		var article_container_ui: ArticleContainerUI = article_container_ui_scene.instantiate()
		article_container_ui.article = article
		articles_v_box_container.add_child(article_container_ui)
		article_container_ui.title_link_button.pressed.connect(go_to_article.bind(article))

func go_to_article(article:Article) -> void:
	current_window_type = WINDOW_TYPE.IN_ARTICLE
	current_article = article
	
	for child: Node in article_container.get_children():
		child.queue_free()
	
	var article_content_container_ui: ArticleContentContainerUI = article_content_container_ui_scene.instantiate()
	article_content_container_ui.article = article
	article_container.add_child(article_content_container_ui)
