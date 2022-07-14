extends Node2D

func _on_bullet_fired(bullet, given_position, direction):
	add_child(bullet)
	bullet.global_position = given_position
	bullet._set_direction(direction)
