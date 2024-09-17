extends PlayerState

@export var fall: State

@onready var timer: Timer = $HitTimer

var current_hit: HitInfo

var has_ended: bool

func start():
	Global.freeze_frame_effect(0.05, 0.4)
	var current_hit = context.most_recent_hit
	has_ended = false
	context.is_hit = false
	
	context.current_health -= current_hit.damage_dealt
	context.health_updated.emit(context.current_health)
	context.start_invulnerability()
	
	var tween = get_tree().create_tween()
	tween.tween_method(set_shader_blink_intensity, 1.0, 0.0, 0.5)
	
	
	context.velocity = current_hit.hit_force * current_hit.hit_direction
	timer.start()

func physics_update(delta):
	context.velocity.y += context.GRAVITY * delta
	
	_check_for_state_change()

func end():
	pass

func _check_for_state_change():
	
	if has_ended:
		state_machine.transition_to_state(fall)
		return
	
	super()

func _on_hit_timer_timeout():
	has_ended = true

func set_shader_blink_intensity(new_intensity: float):
	context.sprite.material.set_shader_parameter("blink_intensity", new_intensity)
