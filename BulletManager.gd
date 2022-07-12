extends Node2D

func _on_bullet_fired(bullet, position, direction):
	add_child(bullet)
	bullet.global_position = position
	bullet._set_direction(direction)
