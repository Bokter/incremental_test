class_name AugmentExtraWeapon
extends Augment

@export var weapon_scene: PackedScene

func on_acquire(player) -> void:
	player.add_passive_weapon(weapon_scene)
