class_name DamageIncreaseEffect
extends HitEffect

@export var damage_increase: int

func apply_effect(hit_info: HitInfo) -> void:
	hit_info.damage_dealt += damage_increase
