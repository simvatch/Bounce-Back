extends Node2D

signal collected

var picked_up := false

func _ready() -> void:
	add_to_group("spray_cans")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if picked_up or not body is CharacterBody2D:
		return
	picked_up = true
	collected.emit()
	queue_free()
