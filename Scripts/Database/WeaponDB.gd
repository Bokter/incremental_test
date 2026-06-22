extends Node

@export var weapons: Array[WeaponData]
var _by_id: Dictionary = {}

func _ready():
	for w in weapons:
		_by_id[w.id] = w

func get_weapon(id: String) -> WeaponData:
	return _by_id.get(id)
