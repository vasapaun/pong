extends RigidBody2D

var SHOULD_RESET:bool = false
var START_POSITION:Vector2 = Vector2(400,300)
var SCALAR_VELOCITY:float = 600

var i = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# Internal physics calculations (Called every frame)
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:

	# Keep the ball's speed constant, and give it a minimum y velocity through angle calculation
	var new_velocity = state.get("linear_velocity")

	if(abs(new_velocity.normalized().y) > 0.8):
		new_velocity = Vector2(new_velocity.normalized().x, sign(new_velocity.y)*0.75) * SCALAR_VELOCITY
	else:
		new_velocity = new_velocity.normalized() * SCALAR_VELOCITY

	state.set("linear_velocity", new_velocity)


	if SHOULD_RESET:
		SHOULD_RESET = false

		# Set it back to original position
		var new_transform = state.get("transform")
		new_transform.origin = Vector2(400,300)
		state.set("transform", new_transform)

		# Set velocity vector's direction to random from [-pi/4, pi/4] U [3pi/4, 5pi/4]
		var angle = random_angle()
		var directionVector = Vector2(cos(angle), sin(angle))
		new_velocity = state.get("linear_velocity")
		new_velocity = directionVector * SCALAR_VELOCITY
		state.set("linear_velocity", new_velocity)

func reset() -> void:
	SHOULD_RESET = true

# Generate random angle from [-pi/4, pi/4] U [3pi/4, 5pi/4]
func random_angle():
	var ranges = [
		Vector2(-PI / 4, PI / 4),           # First range
		Vector2(3 * PI / 4, 5 * PI / 4)    # Second range
	]

	# Pick a random range
	var selected_range = ranges[randi() % ranges.size()]

	# Generate a random angle within the selected range
	return randf_range(selected_range.x, selected_range.y)

func get_direction() -> bool:
	if self.velocity.x < 0:
		return false
	return true

func get_height() -> float:
	return self.transform.origin.y
