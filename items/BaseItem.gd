extends RigidBody2D
class_name BaseItem

signal item_died
signal item_hit(damages: int)
signal projectile_hit(damages_avoided: int)

@export var mouse_spring_constant := 50.0
@export var inertia_factor := 1000.0
@export var initial_stats: Stats

@onready var stats: Stats = initial_stats.duplicate()
@onready var damage_number_template = preload("res://items/DamageNumber.tscn")

const DAMAGE_NUMBER_HEIGHT := 200.0
const DAMAGE_NUMBER_SPREAD := 50.0

var dragging = false
var damage_number_pool: Array[DamageNumber] = []

func add_damage(damages: int, damage_location: Vector2, damage_angle: float):
	var abs_damages = abs(damages)
	stats.health_points -= abs_damages
	spawn_damage_number(abs_damages, damage_location, damage_angle)
	print("["+name+"] Health changed: %s" % stats.health_points)
	item_hit.emit(abs_damages)

func get_stats() -> Stats:
	return stats

func move_item_and_collide(delta, target_position: Vector2):
	var collision = move_and_collide(mouse_spring_constant * target_position * delta)
	if collision and collision.get_collider() is BaseItem:
		var collider: BaseItem = collision.get_collider()
		collider.apply_impulse(collision.get_travel() * inertia_factor * delta)
		# get_viewport().warp_mouse(get_local_mouse_position() * Vector2(10.0, 10.0) * delta)
		# TODO: apply impulse without stopping dragging
		dragging=false
		apply_impulse(-collision.get_travel() * inertia_factor * delta)
		var velocity_damage_multiplier = collision.get_travel().length() / 10.0
		var damages = round(
				stats.hit_damage * stats.hit_damage_multiplier * velocity_damage_multiplier)
		collider.add_damage(damages, collider.get_center_of_mass(),
				collision.get_travel().angle())
		add_damage(round(1 * stats.hit_stength_multiplier * velocity_damage_multiplier),
				get_center_of_mass(), collision.get_travel().angle())
	#elif collision and collision.get_collider() is Projectile:
		#projectile_hit.emit(damages_avoided)

func _process(delta):
	if dragging:
		move_item_and_collide(delta, get_local_mouse_position())
	if stats.health_points <= 0:
		print("["+name+"] died")
		item_died.emit()
		# TODO: add animation
		queue_free()

func set_dragging(is_dragging: bool):
	dragging = is_dragging

func _on_input_event(_viewport, event, _shape_idx):
	if not (event is InputEventMouseButton):
		return
	
	if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		set_dragging(true)
	elif event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		set_dragging(false)

func spawn_damage_number(value: int, damage_location: Vector2, damage_angle: float):
	var damage_number = get_damage_number()	
	add_child(damage_number, true)
	damage_number.set_values_and_animate(str(value), damage_location,
			DAMAGE_NUMBER_HEIGHT, DAMAGE_NUMBER_SPREAD * damage_angle)

func get_damage_number() -> DamageNumber:
	# get a damage number from the pool
	if damage_number_pool.size() > 0:
		return damage_number_pool.pop_front()
	# create a new damage number if the pool is empty
	else:
		var new_damage_number = damage_number_template.instantiate()
		new_damage_number.tree_exiting.connect(
			func():damage_number_pool.append(new_damage_number))
		return new_damage_number
