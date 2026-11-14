extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("I'm a coin")



func _on_area_2d_body_entered(body: Node2D) -> void:
	print("+1 coin")
	queue_free()
