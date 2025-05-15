class_name HitBox 
extends Area2D

signal received_hit(hit_data: HitData)

func receive_hit(hit_data: HitData):
	print('hit acknowleged by target')

	received_hit.emit(hit_data)
