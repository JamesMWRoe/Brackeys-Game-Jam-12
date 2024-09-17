class_name RainSystem
extends Node2D

var melee_enemy = preload("res://Scenes/Enemies/ground_enemy.tscn")
var aerial_enemy = preload("res://Scenes/Enemies/aerial_enemy.tscn")

@onready var phase_timer = $"../Timers/PhaseTimer"
@onready var spawn_timer = $"../Timers/SpawnTimer"
@onready var enemies = $"../Enemies"
@onready var player = $"../Player"

var enemy_array: Array[Enemy]
var spawn_array: Array[SpawnPoint]

var spawn_rate: float = 3.0
var phase_duration: float = 30.0

var has_spawning_ended: bool

signal rain_started
signal rain_ended

func _ready() -> void:
	_initialise_system()


func _initialise_system() -> void:
	
	print('Spawn system initialised')
	
	for child in get_children():
		print('spawner connected' + child.name)
		spawn_array.append(child)

func begin_phase() -> void:
	phase_timer.wait_time = phase_duration
	spawn_timer.wait_time = spawn_rate
	
	spawn_timer.timeout.connect(_spawn)
	phase_timer.timeout.connect(_finish_spawning)
	
	phase_timer.start()
	spawn_timer.start()
	
	rain_started.emit()
	
	has_spawning_ended = false

func _spawn() -> void:
	
	var random_spawn_index = randi_range(0, spawn_array.size()-1)
	var spawn = spawn_array[random_spawn_index]
	
	print('spawning enemy at ' + spawn.name)
	
	var new_enemy = spawn.get_random_enemy().instantiate() as Enemy
	enemies.add_child(new_enemy)
	new_enemy._instance_enemy(spawn.position, player)
	new_enemy.enemy_died.connect(_on_enemy_death)
	
	enemy_array.append(new_enemy)

func _finish_spawning() -> void:
	
	print('spawning ended')
	
	spawn_timer.stop()
	
	has_spawning_ended = true
	
	if enemy_array.is_empty():
		end_phase()

func end_phase() -> void:
	print('all enemies dead, the rain has finished')
	rain_ended.emit()

func _on_enemy_death(enemy: Enemy) -> void:
	
	print('enemy: ' + enemy.name + ' died')
	
	var enemy_index = enemy_array.find(enemy)
	enemy_array.remove_at(enemy_index)
	
	if !enemy_array.is_empty():
		return
	
	if not has_spawning_ended:
		return
	
	end_phase()
