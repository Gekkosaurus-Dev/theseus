extends Node2D

var enemy_scene = preload("res://top down/enemy_td.tscn")
var root

# Called when the node enters the scene tree for the first time.
func _ready():
	root = $".."
	for n in range(100):
		var enemy = enemy_scene.instantiate()
		root.add_child.call_deferred(enemy)
		enemy.position = find_spawn_location()
		await get_tree().create_timer(1).timeout

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func find_spawn_location():
	var spawn = Vector2(0,0)
	var random = randi_range(1,4)
	if (random == 1): #left side
		spawn.x = -50
		spawn.y = randf_range(-50,700)
	elif (random == 2): #right side
		spawn.x = 1200
		spawn.y = randf_range(-50,700)
	elif (random == 3): #top side
		spawn.x = randf_range(-50,1200)
		spawn.y = -50
	elif (random == 4): #bottom side
		spawn.x = randf_range(-50,1200)
		spawn.y = 700
	#spawn = Vector2(0,0)
	#print("spawn location = " + str(spawn))
	return spawn
