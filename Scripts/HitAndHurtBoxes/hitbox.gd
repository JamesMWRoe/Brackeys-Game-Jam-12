class_name Hitbox
extends Area2D


@export var context: CharacterBody2D
var effect_list: Array[HitEffect]

var hit_force = 300.0
var damage_dealt = 1

func add_effect(effect: HitEffect) -> void:
	effect_list.append(effect)

func remove_effect(effect: HitEffect) -> void:
	if not effect_list.has(effect):
		return
	
	effect_list.erase(effect)
