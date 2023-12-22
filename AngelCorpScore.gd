extends Node

signal remaining_health_changed(remaining_health: int)
signal remaining_characters_changed(remaining_characters: int)
signal kill_count_changed(kill_count: int)
signal money_changed(money: int)

var remaining_health := 0
var remaining_characters := 0
var kill_count := 0
var money := 0

func set_remaining_health(new_remaining_health):
	remaining_health = new_remaining_health
	remaining_health_changed.emit(remaining_health)

func decrement_remaining_health(damages):
	remaining_health = max(remaining_health - damages, 0)
	remaining_health_changed.emit(remaining_health)

func set_remaining_characters(new_remaining_characters):
	remaining_characters = new_remaining_characters
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
