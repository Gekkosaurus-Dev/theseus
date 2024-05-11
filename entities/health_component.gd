extends Node
@export var max_armour_health: int
@export var max_health: int
var armour_health
var health
@export var invincible = false
# Called when the node enters the scene tree for the first time.
func _ready():
	reset_health_bars()
	pass # Replace with function body.

func reset_health_bars():
	armour_health = max_armour_health
	health = max_health
	
func set_health(health_int):
	health = health_int
	
func set_armour(armour_health_int):
	armour_health = armour_health_int
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func get_total_health():
	var total_health =  health + armour_health
	print("health component returned" + str(total_health))
	return total_health
#
func apply_damage(damage_amount):
	if !(invincible):
		if armour_health > 0:
			armour_health -= damage_amount
			if armour_health <= 0:
				print("armour broken!")
				armour_health = 0
		else:
			health -= damage_amount
		#print(health)
		get_parent().damage_taken()
