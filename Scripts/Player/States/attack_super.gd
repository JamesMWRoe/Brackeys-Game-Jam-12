class_name AttackState
extends PlayerState

@export var idle: State

var anim_player: AnimationPlayer
var is_attack_complete: bool = false
 
func start():
	super()
	context.update_direction_facing()

	anim_player = context.animation_player

	
	is_attack_complete = false
	
	anim_player.animation_finished.connect(_on_anim_complete)

func physics_update(delta):
	_check_for_state_change()

func end():
	context.attack_cooldown(0.4)
	
	if anim_player.current_animation == state_anim:
		anim_player.play('RESET')

func _check_for_state_change():
	
	if is_attack_complete:
		state_machine.transition_to_state(idle)
		return

func _on_anim_complete(anim: StringName) -> void:
	print('anim completed')
	if not (anim == state_anim):
		return
	
	print('attack completed')
	is_attack_complete = true

