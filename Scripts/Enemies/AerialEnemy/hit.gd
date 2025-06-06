extends State

@export var idle: State
@export var death: State
@export var hit: State

@onready var hit_timer: Timer = $HitTimer

var is_knockback_finished

func _ready():
	hit_timer.timeout.connect(_on_hit_timer_timeout)

func start():
	super()
	
	var tween = get_tree().create_tween()
	tween.tween_method(set_shader_blink_intensity, 1.0, 0.0, 0.5)
	
	is_knockback_finished = false
	context.is_hit = false
	
	hit_timer.start()


func physics_update(_delta):
	
	_check_for_state_change()

func end():
	super()

func _check_for_state_change():
	
	if context.is_hit:
		state_machine.transition_to_state(hit)
		return
	
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
