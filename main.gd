extends Node2D

var player_score = 0
var cpu_score = 0

const SPEED_UP_INTERVAL = 250
var tick_counter = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	tick_counter += 1
	if tick_counter == SPEED_UP_INTERVAL:
		tick_counter = 0
		speed_up()

func score(scorer:String) -> void:

	if scorer == "player":
		player_score += 1
	elif scorer == "cpu":
		cpu_score += 1

	$Ball.reset()
	$PlayerPaddle.reset()
	$CpuPaddle.reset()
	
	tick_counter = 0

	$PlayerScoreLabel.text = str(player_score)
	$CpuScoreLabel.text = str(cpu_score)

# Track key press and release events
func _input(event: InputEvent):
	if event is InputEventKey and (event.keycode == KEY_Q or event.keycode == KEY_ESCAPE) and event.pressed:
		get_tree().quit()

func get_ball_direction() -> int:
	return $Ball.get_direction()

func get_ball_height() -> float:
	return $Ball.get_height()

func speed_up() -> void:
	$Ball.speed_up()
	# $CpuPaddle.speed_up()
	# $PlayerPaddle.speed_up()
