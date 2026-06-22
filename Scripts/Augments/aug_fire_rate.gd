class_name AugmentFireRate
extends Augment

@export var factor: float = 1

func apply(stats) -> void:
	stats.fire_rate_multiplier *= factor
