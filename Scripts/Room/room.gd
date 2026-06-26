class_name Room
extends Node2D

@export var enemies_to_spawn: Array[PackedScene]
@onready var spawn_points := $Spawners.get_children()

signal room_cleared

var alive: int = 0

func start():
	for i in enemies_to_spawn.size():
		var e = enemies_to_spawn[i].instantiate()
		add_child(e)
		e.global_position = spawn_points[i % spawn_points.size()].global_position
		alive += 1
		e.tree_exited.connect(_on_enemy_died)


func _on_enemy_died():
	alive -= 1
	if alive <= 0:
		room_cleared.emit()
