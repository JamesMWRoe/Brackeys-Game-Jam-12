extends Node2D
class_name State

var context: CharacterBody2D
var state_machine: StateMachine

@export var state_anim: String = "idle"

func start() -> void:
	context.animation_player.play(state_anim)

func update(delta) -> void:
	pass

func physics_update(delta) -> void:
	pass

func end() -> void:
	pass

func _check_for_state_change() -> void:
	pass
