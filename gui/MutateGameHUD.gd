extends Node2D

const BOX_ITEM_SPAWN_MAX_OFFSET = 75
const BOX_ITEM_SPAWN_MIN_OFFSET = -75

@export var add_box_cost = 1000;
@export var add_box_cost_multiplier = 1.5;
@export var add_health_qty = 250;
@export var add_health_cost = 10000;
@export var add_health_cost_multiplier = 1.5;
@export var box_item_size = Vector2(32, 32)

@onready var add_box_cost_btn = $AddBoxButton
@onready var add_box_cost_label = $AddBoxButton/CostLabel
@onready var add_health_cost_btn = $AddHealthButton
@onready var add_health_cost_label = $AddHealthButton/CostLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	set_box_cost(add_box_cost)
	set_health_cost(add_health_cost)

func _process(_delta):
	update_buttons_disabled_state(AngelCorpScore.money)

func _on_add_box_button_pressed():
	if AngelCorpScore.money - add_box_cost < 0:
		return
	spawn_box_item_at_random_position_around_character()
	AngelCorpScore.decrement_money(add_box_cost)
	set_box_cost(add_box_cost * add_box_cost_multiplier)

func spawn_box_item_at_random_position_around_character():
	SpawnManager.spawn_box_item_at_random_around_position(
		get_tree().get_nodes_in_group("character")[0].position, true
	)

func _on_add_health_button_pressed():
	if AngelCorpScore.money - add_health_cost < 0:
		return
	AngelCorpScore.increment_remaining_health(add_health_qty)
	AngelCorpScore.decrement_money(add_health_cost)
	set_health_cost(add_health_cost * add_health_cost_multiplier)

func set_box_cost(new_box_cost: int):
	add_box_cost = new_box_cost;
	add_box_cost_label.text = "$%sk" % snapped(new_box_cost / 1000.0, 0.1)

func set_health_cost(new_health_cost: int):
	add_health_cost = new_health_cost;
	add_health_cost_label.text = "$%sk" % snapped(new_health_cost / 1000.0, 0.1)

func update_buttons_disabled_state(money):
	add_box_cost_btn.disabled = money < add_box_cost
	add_health_cost_btn.disabled = money < add_health_cost
