extends Node2D

const TIME_LIMIT := 60.0
const WIN_SCENE := "res://winning.tscn"
const LOSE_SCENE := "res://loosing.tscn"
const BONUS_TIME := 2.0

var timer: Timer
var time_label: Label
var finished := false

@onready var goal: Area2D = $Area2D

func _ready() -> void:
	timer = Timer.new()
	timer.wait_time = TIME_LIMIT
	timer.one_shot = true
	timer.timeout.connect(_on_time_up)
	add_child(timer)
	timer.start()

	goal.set_collision_mask_value(2, true)
	goal.body_entered.connect(_on_goal_body_entered)

	_build_timer_label()

	for can in get_tree().get_nodes_in_group("spray_cans"):
		can.collected.connect(_on_spray_can_collected)


func _process(_delta: float) -> void:
	if finished:
		return
	var seconds_left := int(ceil(timer.time_left))
	time_label.text = "%d:%02d" % [seconds_left / 60, seconds_left % 60]
	time_label.modulate = Color(1, 0.3, 0.3) if seconds_left <= 10 else Color.WHITE

func _on_spray_can_collected() -> void:
	if finished:
		return
	timer.start(timer.time_left + BONUS_TIME)

func _build_timer_label() -> void:
	var hud := CanvasLayer.new()
	add_child(hud)
	time_label = Label.new()
	time_label.add_theme_font_override("font", preload("res://static/Firjar-Medium.ttf"))
	time_label.add_theme_font_size_override("font_size", 48)
	time_label.add_theme_color_override("font_outline_color", Color.BLACK)
	time_label.add_theme_constant_override("outline_size", 8)
	time_label.position = Vector2(20, 10)
	hud.add_child(time_label)


func _on_goal_body_entered(body: Node2D) -> void:
	if finished or not body is CharacterBody2D:
		return
	finished = true
	timer.stop()
	get_tree().change_scene_to_file.call_deferred(WIN_SCENE)

func _on_time_up() -> void:
	if finished:
		return
	finished = true
	get_tree().change_scene_to_file.call_deferred(LOSE_SCENE)
