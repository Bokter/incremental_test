extends Area2D

@export var speed: float = 800.0
@export var lifetime: float = 1.0
@export var turn_speed: float = 10  # qué tan brusco gira 

var damage: float
var homing: bool = false

func _ready():
	$Timer.wait_time = lifetime
	$Timer.start()

func _on_timer_timeout():
	queue_free()
	
func _physics_process(delta):
	if homing:
		var target = get_nearest_enemy()
		if target:
			var desired = (target.global_position - global_position).angle()
			rotation = lerp_angle(rotation, desired, turn_speed * delta)
			
	position += transform.x * speed * delta

func get_nearest_enemy() -> Node2D:
	var nearest: Node2D = null
	var best_dist := INF
	for e in get_tree().get_nodes_in_group("Enemies"):
		var d = global_position.distance_squared_to(e.global_position)
		if d < best_dist:
			best_dist = d
			nearest = e
	return nearest

func _on_body_entered(body):
	if body.is_in_group("Enemies"):
		queue_free()
