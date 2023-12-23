extends Node

signal total_characters_changed(total_characters: int)
signal remaining_characters_changed(remaining_characters: int)
signal kill_count_changed(kill_count: int)
signal money_changed(money: int)

const INIT_TOTAL_CHARACTERS = 0
const INIT_REMAINING_CHARACTERS = 0
const INIT_KILL_COUNT = 0
const INIT_MONEY = 0

var total_characters := 0
var remaining_characters := 0
var kill_count := 0
var money := 0

## Inits score values & triggers signals
func init():
	set_total_characters(INIT_TOTAL_CHARACTERS)
	set_remaining_characters(INIT_REMAINING_CHARACTERS)
	set_kill_count(INIT_KILL_COUNT)
	set_money(INIT_MONEY)

func set_total_characters(new_total_characters):
	total_characters = new_total_characters
	total_characters_changed.emit(total_characters)

func increment_total_characters():
	total_characters = total_characters + 1
	total_characters_changed.emit(total_characters)

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
