extends CharacterBody2D



func _physics_process(delta):
	pass
	
func start_particles():
	$GPUParticles2D.emitting = true

	
func end_particles():
	$GPUParticles2D.emitting = false



func _on_timer_timeout():
	$AnimationPlayer.play("attack")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "attack":
		$AnimationPlayer.play("idle")
		$Timer.start()
