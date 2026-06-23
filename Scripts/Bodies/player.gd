extends CharacterBody2D
const SPEED = 300.0

@export var damage_multiplier: float = 1.0
@export var fire_rate_multiplier: float = 1.0
@export var starting_weapons: Array[PackedScene]
@export var weapons: Array[Area2D]

@export var test_augment: Array[Augment] = []

var max_weapons = 2
var current_weapon_index: int = 0

@export var orbit_radius: float = 50.0
var orbit_weapons: Array[Node2D] = []


func _ready():
	Multiplier.player = self
	for scene in starting_weapons:
		var w = scene.instantiate()
		add_child(w)
		weapons.append(w)
	update_active_weapon()
	
func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			switch_weapon(1)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			switch_weapon(-1)
			
	if event.is_action_pressed("ui_accept"):  
		Multiplier.add_augment(test_augment[0])
		print("+1.5 Shot Speed")
		
	if event.is_action_pressed("cheat"):  
		Multiplier.add_augment(test_augment[1])
		print("+1.5 Fire Rate")
	
	if event.is_action_pressed("cheat2"):  
		Multiplier.add_augment(test_augment[2])
		print("Homing Bullets")
		
	if event.is_action_pressed("cheat3"):  
		Multiplier.add_augment(test_augment[3])
		print("More Weapons")
	
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

func add_passive_weapon(scene: PackedScene):
	var w = scene.instantiate()
	add_child(w)
	w.visible = true
	w.set_process(true)
	orbit_weapons.append(w)
	arrange_orbit()

func arrange_orbit():
	var count = orbit_weapons.size()
	for i in count:
		var angle = TAU * i / count
		orbit_weapons[i].position = Vector2(orbit_radius, 0).rotated(angle)  
	

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
