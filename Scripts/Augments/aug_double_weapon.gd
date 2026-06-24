class_name AugmentExtraWeapon
extends Augment

func on_acquire(player) -> void:
	player.add_passive_weapon(player.get_current_weapon())
