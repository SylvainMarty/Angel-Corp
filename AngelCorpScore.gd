extends Node

signal remaining_health_changed(remaining_health: int)
signal remaining_characters_changed(remaining_characters: int)
signal kill_count_changed(kill_count: int)
signal money_changed(money: int)

const INIT_REMAINING_HEALTH = 0
const INIT_REMAINING_CHARACTERS = 0
const INIT_KILL_COUNT = 0
const INIT_MONEY = 0

var remaining_health := 0
var remaining_characters := 0
var kill_count := 0
var money := 0

## Inits score values & triggers signals
func init():
	set_remaining_health(INIT_REMAINING_HEALTH)
	set_remaining_characters(INIT_REMAINING_CHARACTERS)
	set_kill_count(INIT_KILL_COUNT)
	set_money(INIT_MONEY)

func set_remaining_health(new_remaining_health):
	remaining_health = new_remaining_health
	remaining_health_changed.emit(remaining_health)

func increment_remaining_health(healing):
	remaining_health = remaining_health + healing
	remaining_health_changed.emit(remaining_health)

func decrement_remaining_health(damages):
	remaining_health = max(remaining_health - damages, 0)
	remaining_health_changed.emit(remaining_health)

func set_remaining_characters(new_remaining_characters):
	remaining_characters = new_remaining_characters
	remaining_characters_changed.emit(remaining_characters)

func increment_remaining_characters():
	remaining_characters = remaining_characters + 1
	remaining_characters_changed.emit(remaining_characters)

func decrement_remaining_characters():
	remaining_characters = max(remaining_characters - 1, 0)
	remaining_characters_changed.emit(remaining_characters)

func set_kill_count(new_kill_count):
	kill_count = new_kill_count
	kill_count_changed.emit(kill_count)

func increment_kill_count():
	kill_count += 1
	kill_count_changed.emit(kill_count)

func set_money(new_money):
	money = new_money
	money_changed.emit(money)

func increment_money(money_to_add):
	money += money_to_add
	money_changed.emit(money)

func decrement_money(money_to_remove):
	money -= money_to_remove
	money_changed.emit(money)
