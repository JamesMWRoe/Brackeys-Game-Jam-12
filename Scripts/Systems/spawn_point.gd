class_name SpawnPoint
extends Node2D

@export var spawn_list: Array[Resource]

func get_random_enemy() -> Resource:
	var random_index = randi_range(0, spawn_list.size()-1)
	
	return spawn_list[random_index]
