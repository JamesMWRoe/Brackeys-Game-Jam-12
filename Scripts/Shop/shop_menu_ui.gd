extends Control

@onready var shop_manager: Shop = $"../.."

# Called when the node enters the scene tree for the first time.
func _ready():

	shop_manager.browsing_begun.connect(open_ui)
	shop_manager.browsing_ended.connect(close_ui)
	
	close_ui()


func open_ui() -> void:

	visible = true

func close_ui() -> void:
	visible = false
