class_name AugmentFireRateBoost
extends Augment

@export var factor: float = 1

func apply(stats) -> void:
	stats.fire_rate_multiplier *= factor
