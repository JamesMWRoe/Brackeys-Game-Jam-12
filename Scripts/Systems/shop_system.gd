class_name CalmSystem
extends Node2D

@onready var calm_timer: Timer = $"../Timers/CalmTimer"
var shops: Array[Shop]

var phase_duration: float = 15.0

signal calm_begun
signal calm_ended

func _ready() -> void:
	for child in get_children():
		if child is Shop:
			shops.append(child)
			child.browsing_begun.connect(_pause_calm_timer)
			child.browsing_ended.connect(_play_calm_timer)
			child.close()
		
		calm_timer.wait_time = phase_duration
		

func begin_phase() -> void:
	for shop in shops:
		shop.open()
	
	calm_timer.start()
	calm_begun.emit()

func end_phase() -> void:
	for shop in shops:
		shop.close()
	
	calm_ended.emit()

func _pause_calm_timer():
	print('paused calm timer')
	calm_timer.paused = true

func _play_calm_timer():
	print('unpaused calm timer')
	calm_timer.paused = false

func _on_calm_timer_timeout():
	end_phase()
