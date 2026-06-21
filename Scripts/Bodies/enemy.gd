extends CharacterBody2D

@export var life: float = 1000.0

func _on_hit(area):
	
	if area.is_in_group("Bullets"):
		life -= area.damage
	
	print("Vida actual: ",life)
