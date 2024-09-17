class_name HealthIncreaseEffect
extends PlayerEffect

@export var health_increase: int

func apply_effect(player: Player):
	player.increase_max_health(health_increase)

func remove_effect(player: Player):
	player.increase_max_health(-health_increase)
