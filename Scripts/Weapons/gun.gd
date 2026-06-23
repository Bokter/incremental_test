extends Area2D

@export var data: GunData 
@export var can_shoot: bool = true
@export var barrels: Array[Node2D] 
@onready var timer: Timer = $Timer

var current_bullets: int

func _ready():
	current_bullets = data.bullets

func _process(_delta):
	
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("trigger") && can_shoot && current_bullets > 0:
		shoot()
	pass
	
func shoot():
	
	#print("Tiempo del fire_rate: ", data.fire_rate)
	#print("Shot Speed: ", data.shot_speed * Multiplier.shot_speed_multiplier)
	current_bullets -= 1
	#print("Balas restantes: ", current_bullets)
	can_shoot = false
	timer.wait_time = data.fire_rate / Multiplier.fire_rate_multiplier
	timer.start()
	
	for i in barrels:
		
		var instance = data.bullet.instantiate()
		
		instance.lifetime = data.bullet_lifetime
		instance.rotation = global_rotation
		instance.global_position = i.global_position
		
		instance.homing = Multiplier.homing
		instance.speed = data.shot_speed * Multiplier.shot_speed_multiplier
		instance.damage = data.damage * Multiplier.damage_multiplier
		
		get_tree().current_scene.add_child.call_deferred(instance)

func _shoot_cooldown():
	can_shoot = true
