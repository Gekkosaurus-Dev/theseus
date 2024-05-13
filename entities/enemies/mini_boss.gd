extends CharacterBody2D

@export var animation_player: AnimationPlayer



enum EnemyStates {ATTACKING, MOVING, IDLE}
var enemy_state
var can_attack = true
var prev_state

var player

@export var attack_area: Area2D

@export var attack_cooldown_timer: Timer

@export var max_speed = 300

func _ready():
	player = $"../player_new"
	enemy_state = EnemyStates.IDLE

func _physics_process(_delta):
	
	if (enemy_state == EnemyStates.IDLE):
		animation_player.play("idle")
	elif (enemy_state == EnemyStates.MOVING):
		animation_player.play("walk")
		var direction = global_position.direction_to(player.get_target_position())
		velocity = direction * max_speed
		move_and_slide()
	
func damage_taken():
	play_damage_animation()

func play_damage_animation():
	var sprite = $DirectionFlipper/Sprite
	sprite.modulate = "000000"
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = "62465a"
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = "000000"
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = "62465a"
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = "000000"
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = "62465a"
	await get_tree().create_timer(0.5).timeout

func _on_attack_area_body_entered(body):
	var type = body.get_groups()
	if (type.has("player")):
		attack()

func attack():
	prev_state = enemy_state
	enemy_state = EnemyStates.ATTACKING
	animation_player.play("attack")
	can_attack = false
	attack_cooldown_timer.start()

func _on_animation_player_animation_finished(anim_name):
	if (anim_name == "attack"):
		enemy_state = EnemyStates.IDLE

func _on_attack_cooldown_timeout():
	#print("timedout")
	can_attack = true
	enemy_state = prev_state
	for x in attack_area.get_overlapping_bodies():
		if x.get_groups().has("player"):
			attack()
	
func _on_detection_area_body_entered(body):
	var type = body.get_groups()
	if (type.has("player")):
		enemy_state = EnemyStates.MOVING

func _on_detection_area_body_exited(body):
	var type = body.get_groups()
	if (type.has("player")):
		enemy_state = EnemyStates.IDLE
