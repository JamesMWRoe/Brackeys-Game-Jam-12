class_name  ShopDescriptionUI
extends Control

@onready var shop_manager: Shop = $"../../.."
@onready var name_panel: Label = $VBoxContainer/Name
@onready var description_panel: Label = $VBoxContainer/Description
@onready var cost_panel: Label = $VBoxContainer/Cost

func _ready() -> void:
	shop_manager.new_item_hovered.connect(update_description)

func update_description(item_index: int) -> void:
	
	if item_index < 0:
		name_panel.text = ''
		description_panel.text = 'Nothing Else To Purchase'
		cost_panel.text = ''
		return
	
	var item = shop_manager.current_inventory[item_index]
	
	name_panel.text = item.name
	description_panel.text = item.description
	cost_panel.text = str(item.cost) + ' power points'
