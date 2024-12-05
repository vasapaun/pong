extends Node2D

var player_score = 0
var cpu_score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func score(scorer:String) -> void:

	if scorer == "player":
		player_score += 1
	else:
		cpu_score += 1

	$Ball.reset()
	$PlayerPaddle.reset()
	$CpuPaddle.reset()

	$PlayerScoreLabel.text = str(player_score)
	$CpuScoreLabel.text = str(cpu_score)

# Track key press and release events
func _input(event: InputEvent):
	if event is InputEventKey and (event.keycode == KEY_Q or event.keycode == KEY_ESCAPE) and event.pressed:
		get_tree().quit()

func get_ball_direction() -> bool:
	return $Ball.get_direction()

func get_ball_height() -> float:
	return $Ball.get_height()
