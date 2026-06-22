class_name Enemy
extends CharacterBody2D

@export var speed: float = 100.0
@export var life: float = 100.0
@export var contact_damage: float = 10.0

func _on_hit(area):
	if area.is_in_group("Bullets") or area.is_in_group("Slashes"):
		take_damage(area.damage)

func take_damage(amount: float):
	life -= amount
	if life <= 0:
		die()

func die():
	queue_free()   # las subclases pueden sobrescribir (drop, explosión...)
