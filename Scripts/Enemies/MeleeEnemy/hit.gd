extends State

@export var idle: State
@export var death: State

@onready var hit_timer: Timer = $HitTimer

var hit_info: HitInfo
var is_knockback_finished

func start():
	
	hit_info = context.hit_info
	
	context.current_health -= hit_info.damage_dealt
	
	print(context.name + ' knocked back: ' + str(hit_info.hit_force * hit_info.hit_direction))
	context.velocity.x = hit_info.hit_force * hit_info.hit_direction.x
	
	var tween = get_tree().create_tween()
	tween.tween_method(set_shader_blink_intensity, 1.0, 0.0, 0.5)
	
	
	context.make_invulnerable()
	
	is_knockback_finished = false
	context.is_hit = false
	
	
	
	hit_timer.start()


func physics_update(delta):
	
	context.velocity.y += context.GRAVITY * delta
	_check_for_state_change()

func end():
	pass

func _check_for_state_change():
	
	if context.current_health <= 0:
		state_machine.transition_to_state(death)
		return
	
	if is_knockback_finished:
		state_machine.transition_to_state(idle)
		return


func _on_hit_timer_timeout():
	is_knockback_finished = true

func set_shader_blink_intensity(new_intensity: float):
	context.sprite.material.set_shader_parameter("blink_intensity", new_intensity)
