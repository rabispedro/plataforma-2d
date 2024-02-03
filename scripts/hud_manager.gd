class_name HUDManager
extends Control

signal time_is_up()

@export_category("Properties")
@export_range(0,5) var default_minutes: int = 1
@export_range(0,59) var default_seconds: int = 0

var minutes: int = 0
var seconds: int = 0

@onready var coins_counter: Label = $container/coins_container/coins_counter
@onready var timer_counter: Label = $container/timer_container/timer_counter
@onready var score_counter: Label = $container/score_container/score_counter
@onready var life_counter: Label = $container/life_container/life_counter
@onready var clock_timer: Timer = $clock_timer

func _ready() -> void:
	coins_counter.text = str("%04d" % Globals.coins)
	score_counter.text = str("%06d" % Globals.coins)
	life_counter.text = str("%02d" % Globals.player_life)
	timer_counter.text = str("%02d" % default_minutes) + ":" + str("%02d" % default_seconds)
	reset_clock_timer()
	return

func _process(delta) -> void:
	coins_counter.text = str("%04d" % Globals.coins)
	score_counter.text = str("%06d" % Globals.score)
	life_counter.text = str("%02d" % Globals.player_life)
	
	if minutes == 0 and seconds == 0:
		emit_signal("time_is_up")
	return

func _on_clock_timer_timeout() -> void:
	if seconds == 0:
			if minutes > 0:
				minutes -= 1
				seconds = 60
	seconds -= 1
	
	timer_counter.text = str("%02d" % minutes) + ":" + str("%02d" % seconds)
	return

func reset_clock_timer() -> void:
	minutes = default_minutes
	seconds = default_seconds
	return
