extends CharacterBody2D

const SPEED = 300.0

@export var damage_multiplier: float = 1.0
@export var fire_rate_multiplier: float = 1.0

func _ready():
	Multiplier.set_damage_multiplier(damage_multiplier)
	Multiplier.set_fire_rate_multiplier(fire_rate_multiplier)

func _physics_process(_delta):

	var direction_x = Input.get_axis("left", "right")
	var direction_y = Input.get_axis("up", "down")
	
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	move_and_slide()


func _on_enemy_area_entered(_area):
	pass
