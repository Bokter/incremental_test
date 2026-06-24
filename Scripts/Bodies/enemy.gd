class_name Enemy
extends CharacterBody2D

@export var speed: float = 60.0
@export var life: float = 100000.0
@export var contact_damage: float = 1.0

var player_in_contact: Node = null

func _on_hit(area):
	if area.is_in_group("Bullets") or area.is_in_group("Slashes"):
		take_damage(area.damage)

func take_damage(amount: float):
	life -= amount
	print("Enemy HP: ",life)
	if life <= 0:
		die()

func _physics_process(_delta):
	if GameState.player:
		velocity = global_position.direction_to(GameState.player.global_position) * speed
		move_and_slide()
		
	if player_in_contact:
		player_in_contact.take_damage(contact_damage)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		player_in_contact = body
	
func _on_body_exited(body):
	if body == player_in_contact:
		player_in_contact = null

func die():
	queue_free()   # las subclases pueden sobrescribir (drop, explosión...)
