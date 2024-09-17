class_name HealthRestoreEffect
extends PlayerEffect

@export var health_restored: int

func apply_effect(player: Player):
	player.restore_health(health_restored)

func remove_effect(player: Player):
	pass
