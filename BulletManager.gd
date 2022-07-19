# BulletManager - Instancing of bullet in game environment 
extends Node2D

# Puts the bullet into the game environment
# _on_bullet_fired(bullet: Bullet, given_position: Vector2, direction: Vector2): void
func _on_bullet_fired(bullet, given_position, direction):
	add_child(bullet)
	bullet.global_position = given_position
	bullet._set_direction(direction)
