extends Area2D

var doing_damage = true
@export var damage_amount: int

# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionShape2D.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_entered(area):
	pass

