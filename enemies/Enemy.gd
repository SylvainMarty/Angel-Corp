extends BaseItem
class_name Enemy

@export var movement_speed: float = 0.1
@export var character_attack_impulse: float = 100.0
@export var item_push_impulse: float = 10.0
@export var item_push_back_impulse: float = 0.2

@onready var projectile_template = preload("res://projectiles/projectile.tscn")

func _ready():
	$AnimatedSprite2D.play()

func find_closest_target() -> Node2D:
	var characters = get_tree().get_nodes_in_group("character")
	return characters[0] if not characters.is_empty() else null

func _on_MovementTimer_timer_timeout():
	if dragging:
		return
	advance_to_target()

func advance_to_target():
	var closest_character = find_closest_target()
	if not closest_character:
		return
	# TODO: Use NavAgent instead
	# https://docs.godotengine.org/en/stable/tutorials/navigation/navigation_introduction_2d.html
	# https://github.com/sjharb/NavigationServer2DTest/blob/main/player.gd
	var next_position = (closest_character.get_position() - position) * movement_speed
	print("Enemy move to: ", str(next_position))
	var collision = move_and_collide(next_position)
	if collision:
		play_attack_animation()
	if collision and collision.get_collider() is Character:
		var collider: Character = collision.get_collider()
		collider.add_damage(round(
				stats.hit_damage * stats.hit_damage_multiplier),
				collider.get_center_of_mass(), collision.get_travel().angle())
		collider.apply_impulse(collision.get_travel() * character_attack_impulse)
	elif collision and collision.get_collider() is BaseItem:
		var collider: BaseItem = collision.get_collider()
		var velocity_damage_multiplier = collision.get_travel().length() / 10.0
		collider.add_damage(round(
				1 * stats.hit_stength_multiplier * maxf(1.0, velocity_damage_multiplier)),
				collider.get_center_of_mass(), collision.get_travel().angle())
		collider.apply_impulse(collision.get_travel().rotated(PI/2.0) * item_push_impulse)
		apply_impulse(-collision.get_travel() * item_push_back_impulse)

func play_attack_animation():
	$AnimatedSprite2D.play("attack")

#func _on_ShootingTimer_timer_timeout():
	#shoot()
#
#func shoot():
	#var closest_character: Character = find_closest_target()
	#if not closest_character:
		#return
	#print("shooting projectile")
	#var projectile = get_projectile()
	#owner.add_child(projectile, true)
	#projectile.transform = transform
	#var trajectory = closest_character.get_position() - position
	##projectile.rotation += trajectory.angle()
	#projectile.linear_velocity = trajectory * 3.0
	##projectile.move_item_and_collide(1.0, closest_character.get_position())
	## closest_character.get_position()
#
#func get_projectile() -> Projectile:
	#return projectile_template.instantiate()
