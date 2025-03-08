extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	offset = Vector2(350,0)
	rotation_degrees = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func turn(angle: float) -> void:
	rotation_degrees = angle
