extends CanvasLayer

var game_manager

var full_health_txt = preload("res://entities/player/health_temp/000.png")
var armour_1 =preload("res://entities/player/health_temp/001.png")
var armour_2 =preload("res://entities/player/health_temp/002.png")
var armour_3 = preload("res://entities/player/health_temp/003.png")
var no_armour_txt = preload("res://entities/player/health_temp/004.png")

func get_game_manager():
	game_manager =  get_tree().root.get_child(1)

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
	#$DayCounterUI/DayCounterBar.value = game_manager.days_left
	var top_bar = 50 + (game_manager.days_left/2)
	var bottom_bar = 50 - (game_manager.days_left/2)
	$DayCounterUI/TimerTop.value = top_bar
	$DayCounterUI/TimerTop/TimerBottom.value = bottom_bar
	$DayCounterUI/DayCounterLabel.text = "Days left until attack: " + str(game_manager.days_left)

func update_soul():
	$SoulUI/SoulBar.value = game_manager.soul_percent
	
func set_armour_max(max):
	$InLevelUI/ArmourHealthBar.max_value = max

func set_health_max(max):
	$InLevelUI/PlayerHealthBar.max_value = max

func reset_health():
	$InLevelUI/PlayerHealthBar.value = $InLevelUI/PlayerHealthBar.max_value
	
func reset_armour():
	$InLevelUI/ArmourHealthBar.value = $InLevelUI/ArmourHealthBar.max_value
	
func set_health(value):
	$InLevelUI/PlayerHealthBar.value = value
	
func set_armour(value):
	$InLevelUI/ArmourHealthBar.value = value
	
	if (value >= 100):
		$InLevelUI/Face.texture = (full_health_txt)
	elif (value < 100) and (value > 50):
		$InLevelUI/Face.texture = (armour_1)
	elif (value <= 50) and (value > 25):
		$InLevelUI/Face.texture = (armour_2)
	elif (value <= 25) and (value > 0):
		$InLevelUI/Face.texture = (armour_3)
	else:
		$InLevelUI/Face.texture = (no_armour_txt)
	
	#
#func setup_armour_bar(max_health):
	#$InLevelUI/ArmourHealthBar.max_value = max_health
	#$InLevelUI/ArmourHealthBar.value = max_health
	##$InLevelUI/ArmourHealthBar/ArmourHealthLabel.text = "Armour: 100%"
	##$InLevelUI/UnprotectedHitsLabel.text = ""
	#
#func set_armour_bar(health, max_health):
	##print(health)
	##print(max_health)
	#var armour_percent = (health*100)/max_health
	##print(str(health) + "/" + str(max_health) + "*100 =" +str(armour_percent))
	#$InLevelUI/ArmourHealthBar.value = health
	##$InLevelUI/ArmourHealthBar/ArmourHealthLabel.text = "Armour: " + str(armour_percent) + "%"
	#
	#
#func set_number_hits(value):
	#$InLevelUI/PlayerHealthBar.value = value
	##$InLevelUI/UnprotectedHitsLabel.text = "Unprotected hits taken: " + str(value)
