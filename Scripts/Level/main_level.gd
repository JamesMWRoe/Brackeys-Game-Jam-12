extends Node2D

@onready var camera = $Player/Camera2D
@onready var bounds = $Borders
@onready var rain_particles: RainParticles = $RainParticleSystem
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var thunder_sound: AudioStream

@export var rain_system: RainSystem
@export var calm_system: CalmSystem


func _ready():
	_set_camera_bounds()
	
	
	rain_system.rain_ended.connect(on_rain_end)
	calm_system.calm_ended.connect(on_calm_end)
	
	calm_system.begin_phase()
	rain_particles.change_to_calm_phase()


func _set_camera_bounds():
	camera.limit_left = bounds._get_bound('left')
	camera.limit_right = bounds._get_bound('right')
	camera.limit_top = bounds._get_bound('top')
	camera.limit_bottom = bounds._get_bound('bottom')

func on_rain_end() -> void:

	calm_system.begin_phase()
	rain_particles.change_to_calm_phase()
	audio.stream = thunder_sound
	audio.play()

func on_calm_end() -> void:

	rain_system.begin_phase()
	rain_particles.change_to_rain_phase()
	audio.stream = thunder_sound
	audio.play()

