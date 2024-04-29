extends CanvasLayer

var game_manager

func get_game_manager():
	game_manager =  get_tree().root.get_child(0)

func _ready():
	get_game_manager()
	#setup_day_counter()
	set_day_counter_visibility(false)
	set_level_UI_visibility(false)
	set_soul_visibility(false)

func set_day_counter_visibility(bool):
	$DayCounterUI.visible = bool
	
func set_level_UI_visibility(bool):
	$InLevelUI.visible = bool
	
func set_soul_visibility(bool):
	$SoulUI.visible = bool
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setup_day_counter():
	$DayCounterUI/DayCounterBar.max_value = game_manager.max_days_left
	$DayCounterUI/DayCounterBar.value = game_manager.max_days_left
	$DayCounterUI/DayCounterBar/DayCounterLabel.text = "Days left until attack: " + str(game_manager.max_days_left)

func update_day_counter():
	$DayCounterUI/DayCounterBar.value = game_manager.days_left
	$DayCounterUI/DayCounterBar/DayCounterLabel.text = "Days left until attack: " + str(game_manager.days_left)

func update_soul():
	$SoulUI/SoulBar.value = game_manager.soul_percent
	
func setup_armour_bar(max_health):
	$InLevelUI/ArmourHealthBar.max_value = max_health
	$InLevelUI/ArmourHealthBar.value = max_health
	$InLevelUI/ArmourHealthBar/ArmourHealthLabel.text = "Armour: 100%"
	$InLevelUI/UnprotectedHitsLabel.text = ""
	
func set_armour_bar(health, max_health):
	#print(health)
	#print(max_health)
	var armour_percent = (health*100)/max_health
	#print(str(health) + "/" + str(max_health) + "*100 =" +str(armour_percent))
	$InLevelUI/ArmourHealthBar.value = health
	$InLevelUI/ArmourHealthBar/ArmourHealthLabel.text = "Armour: " + str(armour_percent) + "%"
	
func set_number_hits(value):
	$InLevelUI/UnprotectedHitsLabel.text = "Unprotected hits taken: " + str(value)
