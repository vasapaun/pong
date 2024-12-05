extends Node


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS


func _input(_event):
	if Input.is_action_pressed("pause-resume"):
		get_tree().paused = not get_tree().paused


func _process(_delta):
	if Input.is_action_just_pressed("next-frame"):
		if get_tree().paused:
			get_tree().paused = false
		await get_tree().process_frame
		get_tree().paused = true
