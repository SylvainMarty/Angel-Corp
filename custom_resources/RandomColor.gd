extends Resource
class_name RandomColor

@export_range(0.0, 1.0) var red: float = 0.0
@export_range(0.0, 1.0) var green: float = 0.5
@export_range(0.0, 1.0) var blue: float = 1.0

var base_values := [red, green, blue]

func get_random_color() -> Color:
	var r = 0
	var g = 0
	var b = 0
	while r == 0 and g == 0 and b == 0:
		r = base_values[randi() % base_values.size()]
		g = base_values[randi() % base_values.size()]
		b = base_values[randi() % base_values.size()]
	return Color(r, g, b)
