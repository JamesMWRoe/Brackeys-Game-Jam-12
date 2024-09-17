class_name HeartGui
extends Panel

@onready var sprite: Sprite2D = $Sprite2D

func update(full: bool) -> void:
	if full:
		sprite.frame = 0
		return
	
	sprite.frame = 1
