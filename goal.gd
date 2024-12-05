extends Area2D

# Reference to the Main node
@export var main_node: NodePath


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


# Called when Ball enters the cpu goal
func _on_right_goal_body_entered(body: Node2D) -> void:

	if (body.name != "Ball"):
		return

	get_node(main_node).score("player")
	
	return

# Called when Ball enters the Player goal
func _on_body_entered(body: Node2D) -> void:

	if (body.name != "Ball"):
		return

	get_node(main_node).score("cpu")

	return
