class_name BufferTimer extends Node

@onready var _timer: Timer = $Timer
var _is_valid_input: bool
@export var wait_time: float

func _ready():
	_timer.wait_time = wait_time
	_timer.one_shot = true

func start():
	_timer.start()
	_is_valid_input = true

func stop():
	_timer.stop()

func is_input_valid():
	return _is_valid_input

func _on_timer_timeout():
	_is_valid_input = false
