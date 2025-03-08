extends Node2D

var player_score = 0
var cpu_score = 0

const SPEED_UP_INTERVAL = 250
var tick_counter = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Ball.connect("arrow", _on_arrow)
	kickoff_countdown()

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

	$Ball.start()
	$PlayerPaddle.reset()
	$CpuPaddle.reset()

	tick_counter = 0

	$PlayerScoreLabel.text = str(player_score)
	$CpuScoreLabel.text = str(cpu_score)


	kickoff_countdown()

# Track key press and release events
func _input(event: InputEvent):
	if event is InputEventKey and (event.keycode == KEY_Q or event.keycode == KEY_ESCAPE) and event.pressed:
		get_tree().quit()

func kickoff_countdown():
	var timer = get_tree().create_timer(0.04) # Wait for 0.02 arbitrarily chosen seconds to let the engine naturally reposition the ball
	await timer.timeout

	$Arrow.show()
	$TimerLabel.text = "3"
	$TimerLabel.modulate = Color(0,1,0)
	$TimerLabel.add_theme_font_size_override("font_size", 45)
	$TimerLabel.show()
	await pause_game(1)
	$TimerLabel.text = "2"
	$TimerLabel.modulate = Color(1.0, 0.647, 0.0)
	$TimerLabel.add_theme_font_size_override("font_size", 60)
	await pause_game(1)
	$TimerLabel.text = "1"
	$TimerLabel.modulate = Color(1,0,0)
	$TimerLabel.add_theme_font_size_override("font_size", 75)
	await pause_game(1)
	$TimerLabel.hide()
	$Arrow.hide()

func get_ball_direction() -> int:
	return $Ball.get_direction()

func get_ball_height() -> float:
	return $Ball.get_height()

func speed_up() -> void:
	$Ball.speed_up()

func pause_game(seconds: int) -> void:
	$PauseTimer.process_mode = Timer.PROCESS_MODE_ALWAYS  # Allow Timer to run while paused
	$PauseTimer.start(seconds)
	get_tree().paused = true
	await $PauseTimer.timeout
	get_tree().paused = false

func radToDeg(rad: float) -> float:
	return rad * 180 / PI

func _on_arrow():
	turnArrow($Ball.get_angle())
	showArrow()

func turnArrow(angle: float) -> void:
	$Arrow.turn(radToDeg(angle))

func showArrow() -> void:
	$Arrow.show()
