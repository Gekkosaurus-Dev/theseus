extends Node2D

var game_manager

func get_game_manager():
	game_manager =  get_tree().root.get_child(1)

func _ready():
	get_game_manager()
	game_manager.input_changed.connect(_on_input_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("skip"):
		end_level()
	pass

func player_died():
	end_level()

func end_level():
	Engine.time_scale = 0.1
	$Timer.start()
	game_manager.tutorial_finished(self)

func _on_timer_timeout():
	Engine.time_scale = 1
	
func _on_input_changed():
	if game_manager.game_input == game_manager.GameInputs.KEYBOARD_MOUSE:
		$"Control/MoveInstructions/C-MoveContainer".visible = false
		$"Control/MoveInstructions/K-MoveContainer".visible = true
		
		$"Control/DashInstructions/C-DashContainer".visible = false
		$"Control/DashInstructions/K-DashContainer".visible = true
		
		$"Control/AttackInstructions/C-AttackContainer".visible = false
		$"Control/AttackInstructions/K-AttackContainer".visible = true
	elif game_manager.game_input == game_manager.GameInputs.CONTROLLER:
		$"Control/MoveInstructions/C-MoveContainer".visible = true
		$"Control/MoveInstructions/K-MoveContainer".visible = false
		
		$"Control/DashInstructions/C-DashContainer".visible = true
		$"Control/DashInstructions/K-DashContainer".visible = false
		
		$"Control/AttackInstructions/C-AttackContainer".visible = true
		$"Control/AttackInstructions/K-AttackContainer".visible = false

func boss_died():
	pass
