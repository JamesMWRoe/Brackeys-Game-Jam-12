class_name ShopItemUI
extends Panel

@onready var sprite: Sprite2D = $"Sprite2D"

func update_item(item: Item = null) -> void:

	if not item:
		sprite.texture = null
		return
	
	print('Item: ' + item.name)
	sprite.texture = item.icon

func hovered() -> void:
	sprite.position.y -= 32

func unhovered() -> void:
	sprite.position.y += 32
