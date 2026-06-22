extends CharacterBody2D
const SPEED = 300.0

@export var damage_multiplier: float = 1.0
@export var fire_rate_multiplier: float = 1.0
@export var weapons: Array[Area2D]

var max_weapons = 2
var current_weapon_index: int = 0

func _ready():
	update_active_weapon()

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			switch_weapon(1)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			switch_weapon(-1)

func switch_weapon(direction: int):
	if weapons.is_empty():
		return
	current_weapon_index = wrapi(current_weapon_index + direction, 0, weapons.size())
	update_active_weapon()

func update_active_weapon():
	for i in weapons.size():
		var is_active = (i == current_weapon_index)
		weapons[i].visible = is_active
		weapons[i].set_process(is_active)

func add_weapon(new_weapon: Area2D):
	if weapons.size() < max_weapons:
		weapons.append(new_weapon)
	else:
		weapons[current_weapon_index].queue_free()
		weapons[current_weapon_index] = new_weapon
	
	update_active_weapon()

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
