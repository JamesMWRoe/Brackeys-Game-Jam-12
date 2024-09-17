class_name RainParticles
extends Node

@onready var drop_system: GPUParticles2D = $RainDropParticleSystem
@onready var splash_system: GPUParticles2D = $RainSplashParticlesSystem

@export var rain_phase_info: StormIntensityInfo
@export var calm_phase_info: StormIntensityInfo
@export var storm_phase_info: StormIntensityInfo

var rain_angle: float = 26

func change_to_rain_phase() -> void:
	update_amount_ratio(rain_phase_info)

func change_to_calm_phase() -> void:
	update_amount_ratio(calm_phase_info)
	

func change_to_storm_phase() -> void:
	update_amount_ratio(storm_phase_info)

func update_amount_ratio(info: StormIntensityInfo) -> void:
	splash_system.amount_ratio = info.splash_amount_ratio
	drop_system.amount_ratio = info.rain_amount_ratio
	var process_mat = drop_system.process_material as ParticleProcessMaterial
	process_mat.gravity.y = info.rain_gravity * cos(deg_to_rad(rain_angle))
	process_mat.gravity.x = info.rain_gravity * -sin(deg_to_rad(rain_angle))
