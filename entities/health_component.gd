extends Node

@export var max_health: int
var health
@export var invincible = false
# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
#
func apply_damage(damage_amount):
	if !(invincible):
		health = health - damage_amount
		#print(health)
		get_parent().damage_taken()
