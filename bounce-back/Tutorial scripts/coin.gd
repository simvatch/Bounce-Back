extends Node2D

var count := 0

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("+1 coin")
	count += 1
	queue_free()
