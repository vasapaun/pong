extends CharacterBody2D

@export var main_node: NodePath
var main

var START_POSITION = Vector2(0, 0)

var SPEED = 600

func _ready() -> void:
	main = get_node(main_node)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:

	# Ball can push the paddle on contact, set it back to its original position
	self.position.x = START_POSITION.x


func _physics_process(_delta: float) -> void:

	# Don't follow the ball if the ball is moving towards the player
	if main.get_ball_direction() == DIRECTION.LEFT:
		return

	if self.transform.origin.y < main.get_ball_height():
		self.velocity.y = SPEED
	elif self.transform.origin.y > main.get_ball_height():
		self.velocity.y = -SPEED
	else:
		self.velocity.y = 0

	move_and_slide()


func reset() -> void:
	self.position = START_POSITION
