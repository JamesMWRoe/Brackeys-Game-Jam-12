class_name SpeedIncreaseEffect
extends PlayerEffect

@export var speed_multiplier: float

func apply_effect(player: Player):
	player.stats.speed_multiplier *= speed_multiplier

func remove_effect(player: Player):
	player.stats.speed_multiplier /= speed_multiplier


