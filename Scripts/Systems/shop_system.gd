class_name CalmSystem
extends Node2D

@onready var calm_timer: Timer = $"../Timers/CalmTimer"
var shops: Array[Shop]

signal calm_begun
signal calm_ended

func _ready() -> void:
	for child in get_children():
		if child is Shop:
			shops.append(child)
			child.close()
		
		calm_timer.wait_time = 30
		

func begin_phase() -> void:
	for shop in shops:
		shop.open()
	
	calm_timer.start()
	calm_begun.emit()

func end_phase() -> void:
	for shop in shops:
		shop.close()
	
	calm_ended.emit()


func _on_calm_timer_timeout():
	end_phase()
