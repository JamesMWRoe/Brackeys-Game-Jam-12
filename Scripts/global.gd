extends Node

#only use by accessing generate_unique_id
static var _unique_id_counter: int = 0

func generate_unique_id() -> int:
	_unique_id_counter += 1
	return _unique_id_counter

func freeze_frame_effect(time_scale, duration) -> void:
	Engine.time_scale = time_scale
	await get_tree().create_timer(duration * time_scale).timeout
	Engine.time_scale = 1.0
