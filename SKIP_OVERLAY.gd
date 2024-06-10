extends CanvasLayer

var game_manager

func get_game_manager():
	game_manager =  get_tree().root.get_child(1)

# Called when the node enters the scene tree for the first time.
func _ready():
	get_game_manager()
	$Panel.visible = false
	game_manager.input_changed.connect(_on_input_changed)

func get_input():
	#print("input")
	if Input.is_action_just_pressed("skip_cutscene"):
		#print("skip?")
		get_parent().skip_button_pressed()
		queue_free() 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	get_input()
	pass

func _on_input_changed():
	if game_manager.game_input == game_manager.GameInputs.KEYBOARD_MOUSE:
		$Panel/ControllerSkip.visible = false
		$Panel/KeyboardSkip.visible = true
	elif game_manager.game_input == game_manager.GameInputs.CONTROLLER:
		$Panel/ControllerSkip.visible = true
		$Panel/KeyboardSkip.visible = false

func _on_timer_timeout():
	$Panel.visible = true
