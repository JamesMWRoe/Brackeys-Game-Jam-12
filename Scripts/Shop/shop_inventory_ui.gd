class_name ShopInventoryUI
extends HBoxContainer

@onready var shop_manager: Shop = $"../../.."

var item_ui_array: Array[ShopItemUI]
var current_item_index: int

func _ready():
	shop_manager.new_item_hovered.connect(update_hovered_item)
	shop_manager.inventory_updated.connect(update_inventory)
	shop_manager.item_sold_out.connect(item_bought)

func update_inventory(items: Array[Item]) -> void:
	initialise_inventory()
	var current_index = 0
	for item_ui in item_ui_array:
		if current_index < items.size():
			item_ui.update_item(items[current_index])
			current_index += 1
		else:
			item_ui.update_item()
	
	update_hovered_item(shop_manager.selected_item_index)

func initialise_inventory() -> void:
	item_ui_array = []
	for control in get_children():
		
		if not control is ShopItemUI:
			continue
		
		var item_ui = control as ShopItemUI
		
		item_ui_array.append(item_ui)

func update_hovered_item(item_index: int) -> void:
	print('item index to hover' + str(item_index))
	print('item index to unhover' + str(current_item_index))
	item_ui_array[current_item_index].unhovered()
	current_item_index = item_index
	item_ui_array[current_item_index].hovered()

func item_bought(item_index: int) -> void:
		var current_item_ui = item_ui_array[item_index]
		current_item_ui.update_item()
		item_ui_array.remove_at(item_index)
