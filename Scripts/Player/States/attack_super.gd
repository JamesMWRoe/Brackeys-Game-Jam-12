class_name AttackState
extends PlayerState

@export var idle: State
@export var next_attack: State

var hit_id: int
const attack_complete_cooldown = 0.4

var anim_player: AnimationPlayer
var is_attack_complete: bool = false
 
func start():
	super()

	context.velocity = Vector2.ZERO
	context.update_direction_facing()
	anim_player = context.animation_player
	
	is_attack_complete = false
	
	anim_player.animation_finished.connect(_on_anim_complete)

func physics_update(_delta):
	_check_for_state_change()

func end():
	if anim_player.current_animation == state_anim:
		anim_player.play('RESET')

func _check_for_state_change():
	
	if is_attack_complete:
		if next_attack != null and context.attack_buffer_timer.is_input_valid():
			state_machine.transition_to_state(next_attack)
			return
		else:
			state_machine.transition_to_state(idle)
			context.attack_cooldown(attack_complete_cooldown)
			return

func _on_anim_complete(anim: StringName) -> void:
	print('anim completed')
	if not (anim == state_anim):
		return
	
	print('attack completed')
	is_attack_complete = true

