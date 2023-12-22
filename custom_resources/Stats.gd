extends Resource
class_name Stats

@export var health_points: int
@export var hit_stength_multiplier: float = 1.0
@export var hit_damage: int
@export var hit_damage_multiplier: float = 1.0
@export var dropped_money_min: int = 0
@export var dropped_money_max: int = 0

func get_random_dropped_money():
	if dropped_money_min + dropped_money_max == 0:
		return 0
	return randi() % (dropped_money_max - dropped_money_min) + dropped_money_max
