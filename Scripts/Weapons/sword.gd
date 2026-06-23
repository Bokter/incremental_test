extends Area2D

@export var slash: PackedScene
@export var fire_rate: float = 1.0
@export var slash_duration: float = 0.2  
@export var damage: float = 1.0
@onready var timer: Timer = $Timer
@onready var sword_hitbox: Node2D = $sword_hitbox

var is_attacking: bool = false

func _process(_delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("trigger") && !is_attacking:
		attack()

func attack():

	is_attacking = true
	
	var instance = slash.instantiate()
	instance.damage = damage * Multiplier.damage_multiplier
	instance.lifetime = slash_duration
	
	sword_hitbox.add_child.call_deferred(instance)
	instance.position = Vector2.ZERO
	instance.rotation = 0
	
	timer.wait_time = fire_rate / Multiplier.fire_rate_multiplier
	timer.start()

func _attack_cooldown():
	is_attacking = false
