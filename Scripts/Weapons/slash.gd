extends Area2D

@export var lifetime: float = 1.0
@onready var timer: Timer = $Timer

var damage: float

func _ready():
	$Timer.wait_time = lifetime
	$Timer.start()

func _on_timer_timeout():
	queue_free()
