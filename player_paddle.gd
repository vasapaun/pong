extends CharacterBody2D

var SPEED = 600
var START_POSITION = Vector2(0, 0)
var down:bool = false
var up:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Track key press and release events
func _input(event: InputEvent):
	if event is InputEventKey:
		if event.keycode == KEY_K or event.keycode == KEY_UP:
			if event.pressed:
				up = true
			else:
				up = false
		if event.keycode == KEY_J or event.keycode == KEY_DOWN:
			if event.pressed:
				down = true
			else:
				down = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:

	# Ball can push the paddle on contact, set it back to its original position
	self.position.x = START_POSITION.x

func _physics_process(_delta: float) -> void:

	if up:
		self.velocity.y = -SPEED
	elif down:
		self.velocity.y = SPEED
	else:
		self.velocity.y = 0

	move_and_slide()

func reset() -> void:
	self.position = START_POSITION
	up = false
	down = false
