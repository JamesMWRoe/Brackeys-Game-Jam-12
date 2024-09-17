class_name Shop
extends Area2D

@export var player: Player
@export var camera: Camera2D

var potential_inventory
@export var current_inventory: Array[Item]

signal on_open
signal on_close
signal browsing_begun
signal browsing_ended
signal new_item_hovered(item_index: int)
signal inventory_updated(new_inventory: Array[Item])
signal item_bought(item_index: int)
signal item_sold_out(item_index: int)

var selected_item_index: int = 0

var is_open: bool
var is_browsing: bool

func _ready() -> void:
	if not player:
		player = Player.new()
		player.power_points = 50
	
	open()

func _physics_process(delta) -> void:
	
	if not is_open:
		return
	
	if Input.is_action_just_pressed("look_up") and overlaps_body(player):
		print('begun browsing')
		browsing_begun.emit()
		player.is_disabled = true
		is_browsing = true
	
	if not is_browsing:
		return
	
	if Input.is_action_just_pressed("move_left"):
		goto_previous_item()
		return
	
	if Input.is_action_just_pressed("move_right"):
		goto_next_item()
		return
	
	if Input.is_action_just_pressed("jump"):
		buy_item()
		return
	
	if Input.is_action_just_pressed("cancel"):
		browsing_ended.emit()
		player.is_disabled = false
		is_browsing = false

func open() -> void:
	monitoring = true
	visible = true
	on_open.emit()
	selected_item_index = 0
	update_inventory()
	is_open = true

func close() -> void:
	on_close.emit()
	monitoring = false
	visible = false
	
	is_open = false

func update_inventory() -> void:
	inventory_updated.emit(current_inventory)
	new_item_hovered.emit(selected_item_index)

func goto_previous_item() -> void:
	
	selected_item_index -= 1
	if selected_item_index < 0:
		selected_item_index = current_inventory.size() - 1
	
	print('selected index' + str(selected_item_index))
	new_item_hovered.emit(selected_item_index)

func goto_next_item() -> void:
	selected_item_index += 1
	if selected_item_index >= current_inventory.size():
		selected_item_index = 0
	
	new_item_hovered.emit(selected_item_index)

func buy_item() -> void:
	pass

