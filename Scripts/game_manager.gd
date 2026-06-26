class_name GameManager
extends Node2D

@export var rooms: Array[PackedScene]    # ← aquí SÍ arrastras room.tscn

var current: int = 0
var current_room: Room = null

func _ready():
	start_room(0)

func start_room(index: int):
	if index >= rooms.size():
		print("¡Mazmorra completada!")
		return
	current = index
	current_room = rooms[index].instantiate()
	add_child(current_room)
	current_room.room_cleared.connect(_on_room_cleared, CONNECT_ONE_SHOT)
	current_room.start()

func _on_room_cleared():
	current_room.queue_free()       # libera la room limpiada
	start_room(current + 1)
