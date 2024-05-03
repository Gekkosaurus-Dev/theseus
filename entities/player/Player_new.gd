extends CharacterBody2D

@export var health_component: Node
@export var hitbox: Area2D
var attack_up = true

@export var attack_speed = 1
#@export var attack_cooldown = 0.5

var attacking = false
var attack_dashing = false
var can_attack = true
var can_move = true

@export var max_speed: int
@export var acceleration_value: int
@export var attack_move_speed: int
@export var dash_move_speed: int

@export var animation_player: AnimationPlayer

var dashing = false
var can_dash = true

var game_manager

var attack_direction
var dash_direction

var UI

var max_health

@export var attack_move_cooldown: Timer
@export var attack_cooldown: Timer
@export var attack_move: Timer
@export var dash_timer: Timer
@export var dash_cooldown: Timer

var hits_taken = 0 #specifically unprotected hits taken


enum PlayerStates {ATTACKING, DASHING, OTHER}
var player_state

func get_game_manager():
	game_manager =  get_tree().root.get_child(0)

func _ready():
	player_state = PlayerStates.OTHER
	get_game_manager()
	UI = game_manager.get_child(0)
	print(UI)
	max_health = health_component.max_health
	UI.setup_armour_bar(max_health)
	UI.set_level_UI_visibility(true)
	
func _physics_process(_delta):
	get_input()
	#print("player velocity = " + str(velocity))
	get_attack_direction()
	
	move_and_slide()
	
func get_attack_direction():
	if (game_manager.game_input == game_manager.GameInputs.KEYBOARD_MOUSE):
		attack_direction = global_position.direction_to(get_global_mouse_position())
		$DirectionPointer.rotation = atan2(attack_direction.y, attack_direction.x)
	else:
		var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		if direction:
			attack_direction = direction
			$DirectionPointer.rotation = atan2(attack_direction.y, attack_direction.x)
			
func get_dash_direction():
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		dash_direction = direction
	else:
		dash_direction = attack_direction


func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if Input.is_action_just_pressed("attack_melee"):
		try_attack()
		#$Icon/GPUParticles2D.emitting = true
	if Input.is_action_just_pressed("dash"):
		try_dash()
	
	if (player_state == PlayerStates.ATTACKING) and (attack_dashing):
		velocity = attack_direction * attack_move_speed
	elif (player_state == PlayerStates.DASHING) and (dashing):
		velocity = dash_direction * dash_move_speed	
	elif (player_state == PlayerStates.OTHER):	#not attacking or dashing
		if can_move:
			if input_direction: #if player holding down a movement key
				animation_player.play("run")
				velocity = input_direction * max_speed
			else:
				animation_player.play("idle")
				velocity.y = move_toward(velocity.y, 0, max_speed)
				velocity.x = move_toward(velocity.x, 0, max_speed)		
	else: 
		velocity.y = move_toward(velocity.y, 0, max_speed)
		velocity.x = move_toward(velocity.x, 0, max_speed)
		
func try_attack():
	if (can_attack):
		get_attack_direction()
		animation_player.play("attack")
		#$DirectionPointer/EnemyPusher/EnemyPusherHitbox.disabled = false
		player_state = PlayerStates.ATTACKING
		#attack_cooldown.start()
		attack_dashing = true
		#print("attack move timer")
		attack_move.start()
		can_attack = false
		can_dash = false
		health_component.invincible = true
		set_collision_mask_value(2,false)
		##
		
		#if attack_up:
			#animation_player.play("attack_1")
			##print("attack up")
			#attack_up = false
		#else:
			#animation_player.play("attack_2")
			##print("attack down")
			#attack_up = true
		
	#var attack_state = attack_state * -1
	#if (attack_state == 1):
		#$DirectionFlipper/AnimationPlayer.play("attack_1")
	#if (attack_state == -1):
		#$DirectionFlipper/AnimationPlayer.play("attack_2")
	##await get_tree().create_timer(0.1).timeout
	#hitbox_collider.disabled = true

func try_dash():
	if can_dash:
		player_state = PlayerStates.DASHING
		animation_player.play("dash")
		get_dash_direction()
		dashing = true
		can_dash = false
		can_move = false
		can_attack = false
		#dash_timer.start()
		health_component.invincible = true
		set_collision_layer_value(1,false)
		set_collision_mask_value(2,false)

func damage_taken():
	print("player took damage")
	if health_component.health >= 0:
		UI.set_armour_bar(health_component.health, max_health)
	else:
		hits_taken = hits_taken + 1
		UI.set_armour_bar(0, max_health)
		UI.set_number_hits(hits_taken)
	health_component.invincible = true
	play_damage_animation() #at the end of this, .invincible is set back to false

func play_damage_animation():
	var sprite = $DirectionFlipper/Sprite
	sprite.modulate = "000000"
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = "ffffff"
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = "000000"
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = "ffffff"
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = "000000"
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = "ffffff"
	await get_tree().create_timer(0.5).timeout
	health_component.invincible = false

func get_damage_taken_amount():
	#print ("returning " + str(damage_manager.damage_amount))
	#return damage_manager.damage_amount
	pass

#-----timers-----#
func _on_attack_move_timeout():
	attack_dashing = false
	can_move = false
	#print("start cooldown")
	attack_move_cooldown.start()
	set_collision_mask_value(2,true)

func _on_attack_move_cooldown_timeout():
	#$DirectionPointer/EnemyPusher/EnemyPusherHitbox.disabled = false
	can_move = true

func _on_animation_player_animation_finished(anim_name):
	if (anim_name == "attack"):
		can_attack = true
		can_dash = true
		health_component.invincible = false
		player_state = PlayerStates.OTHER
	elif (anim_name == "dash"):
		dashing = false
		animation_player.play("dash_cooldown")
	elif(anim_name == "dash_cooldown"):
		can_dash = true
		can_move = true
		can_attack = true
		player_state = PlayerStates.OTHER
		set_collision_layer_value(1,true)
		set_collision_mask_value(2,true)
		health_component.invincible = false
		
