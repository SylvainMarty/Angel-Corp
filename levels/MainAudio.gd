extends Node

const ANIMATION_NAME = "fade-in"

@export var volume_offset: float = 0.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var start_ost_player: AudioStreamPlayer = $StartOSTPlayer
@onready var loop_ost_player: AudioStreamPlayer = $LoopOSTPlayer

func _ready():
	setup_audio()
	start_main_audio_loop()

func _exit_tree():
	stop_main_audio_loop()

func setup_audio():
	animation_player.get_animation(ANIMATION_NAME).track_set_key_value(0, 1, -5 + volume_offset)
	loop_ost_player.volume_db += volume_offset

func start_main_audio_loop():
	animation_player.play(ANIMATION_NAME)
	start_ost_player.finished.connect(start_part2_audio_loop)

func start_part2_audio_loop():
	loop_ost_player.play()

func stop_main_audio_loop():
	start_ost_player.finished.disconnect(start_part2_audio_loop)
	animation_player.stop()
	loop_ost_player.stop()
