extends Node2D

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Tutorial scenes/Emily_test_game.tscn")
