class_name VendingShop
extends  Shop

func buy_item() -> void:
	var bought_item_index = selected_item_index
	var item = current_inventory[bought_item_index]
	
	if player.power_points < item.cost:
		print('not enough money, cannot buy')
		return
	
	player.update_pp(-item.cost)
	player.gain_item(item)

	item_bought.emit(bought_item_index)
