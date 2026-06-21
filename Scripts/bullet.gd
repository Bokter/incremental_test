extends Area2D

@export var speed: float = 800.0
@export var lifetime: float = 1.0

var damage: float

func _ready():
	$Timer.wait_time = lifetime
	$Timer.start()

func _on_timer_timeout():
	queue_free()
	
func _physics_process(delta):
	position += transform.x * speed * delta

func _on_body_entered(body):
	if body.is_in_group("Enemies"):
		queue_free()
