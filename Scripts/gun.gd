extends Node2D

@export var bullet: PackedScene
@export var barrels: Array[Node2D] 

@export var fire_rate: float = 0.3

@export var can_shoot: bool = true
@export var bullet_lifetime: float = 1

@export var damage: float = 1.0
@onready var timer: Timer = $Timer

func _process(_delta):
	
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("trigger") && can_shoot:
		shoot()
	pass
	
func shoot():
	
	can_shoot = false
	timer.wait_time = fire_rate / Multiplier.fire_rate_multiplier
	timer.start()
	
	for i in barrels:
		
		var instance = bullet.instantiate()
		
		instance.lifetime = bullet_lifetime
		instance.rotation = global_rotation
		instance.global_position = i.global_position
		instance.damage = damage * Multiplier.damage_multiplier
		get_tree().current_scene.add_child.call_deferred(instance)


func _shoot_cooldown():
	can_shoot = true
