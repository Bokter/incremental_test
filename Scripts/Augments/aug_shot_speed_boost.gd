class_name AugmentShootSpeedBoost
extends Augment

@export var factor: float = 1.5

func apply(stats) -> void:
	stats.shot_speed_multiplier *= factor
