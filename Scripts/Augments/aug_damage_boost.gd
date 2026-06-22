class_name AugmentDamageBoost
extends Augment

@export var factor: float = 1.5

func apply(stats) -> void:
	stats.damage_multiplier *= factor
