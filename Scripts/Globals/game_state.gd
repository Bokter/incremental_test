extends Node

var damage_multiplier: float = 1.0
var fire_rate_multiplier: float = 1.0
var shot_speed_multiplier: float = 1.5

var player: Node2D = null

var homing: bool = false

# Lista de aumentos que el jugador tiene activos
var active_augments: Array[Augment] = []

func add_augment(aug: Augment):
	active_augments.append(aug)
	recalc_stats()
	aug.on_acquire(player)

func remove_augment(aug: Augment):
	active_augments.erase(aug)
	recalc_stats()

func recalc_stats():
	damage_multiplier = 1.0
	fire_rate_multiplier = 1.0
	shot_speed_multiplier = 1.0
	homing = false
	
	# Aplicar todos los aumentos encima
	for aug in active_augments:
		aug.apply(self)
