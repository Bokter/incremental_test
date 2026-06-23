extends Area2D

@export var data: WeaponData 
@export var can_shoot: bool = true
@export var barrels: Array[Node2D] 
@onready var timer: Timer = $Timer

func _process(_delta):
	
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("trigger") && can_shoot:
		shoot()
	pass
	
func shoot():
	
	print("Tiempo del fire_rate: ", data.fire_rate)
	
	can_shoot = false
	timer.wait_time = data.fire_rate / Multiplier.fire_rate_multiplier
	
	
	timer.start()
	
	for i in barrels:
		
		var instance = data.bullet.instantiate()
		instance.lifetime = data.bullet_lifetime
		instance.rotation = global_rotation
		instance.global_position = i.global_position
		instance.damage = data.damage * Multiplier.damage_multiplier
		get_tree().current_scene.add_child.call_deferred(instance)

func _shoot_cooldown():
	can_shoot = true
