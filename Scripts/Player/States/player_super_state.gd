class_name  PlayerState
extends State

@export var death: State
@export var hit: State


func start():
	super()

func update(delta):
	pass

func physics_update(delta):
	_check_for_state_change()

func end():
	pass

func _check_for_state_change():
	if context.current_health <= 0:
		state_machine.transition_to_state(death)
		return
	
	if context.is_hit:
		state_machine.transition_to_state(hit)
		return

