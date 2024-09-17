class_name UpgradeShop
extends Shop

func buy_item() -> void:
	var bought_item_index = selected_item_index
	var item = current_inventory[bought_item_index]
	if player.power_points < item.cost:
		print('not enough money, cannot buy')
		return
	
	player.update_pp(-item.cost)
	player.gain_item(item)
	goto_previous_item()
	current_inventory.remove_at(bought_item_index)
	item_bought.emit(bought_item_index)
	item_sold_out.emit(bought_item_index)
