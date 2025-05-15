extends State

@export var idle: State
@export var hit: State

@onready var hit_timer: Timer = $HitTimer

var is_hit_ended = false

func start():
	print('enemy hit')
	context.is_hit = false

	is_hit_ended = false
	var tween = get_tree().create_tween()
	tween.tween_method(set_shader_blink_intensity, 1.0, 0.0, 0.5)

	hit_timer.start()

func physics_update(_delta):
	_check_for_state_change()

func end():
	pass

func _check_for_state_change():
	if context.is_hit:
		state_machine.transition_to_state(hit)
		return

	if is_hit_ended:
		state_machine.transition_to_state(idle)
		return

func _hit_timer_timeout():
	is_hit_ended = true

func set_shader_blink_intensity(new_intensity: float):
	context.sprite.material.set_shader_parameter("blink_intensity", new_intensity)
