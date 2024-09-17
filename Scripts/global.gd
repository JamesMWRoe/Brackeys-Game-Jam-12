extends Node


func generate_hitinfo(attacker: CharacterBody2D, defender: CharacterBody2D) -> HitInfo:
	var hit_info = HitInfo.new()
	
	hit_info.damage_dealt = attacker.stats.attack
	hit_info.hit_direction = (defender.position - attacker.position).normalized()
	hit_info.hit_force = attacker.stats.hit_force
	
	for effect in attacker.hit_effect_list:
		effect.apply_effect(hit_info)
	
	return hit_info

func freeze_frame_effect(time_scale, duration) -> void:
	Engine.time_scale = time_scale
	await get_tree().create_timer(duration * time_scale).timeout
	Engine.time_scale = 1.0
