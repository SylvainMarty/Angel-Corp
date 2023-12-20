extends BaseItem
class_name Projectile

@export var speed = 100

var target_position: Vector2

#func _physics_process(delta):
	#position += transform.x * speed * delta
	# linear_velocity = (target_position - position) * speed * delta
	#apply_force((target_position - position) * speed * delta)
	#move_and_collide((target_position - position) * speed * delta)
