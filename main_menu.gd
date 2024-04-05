extends Control

func _on_quit_pressed():
	get_tree().quit()

func _on_play_pressed():
	print("a")
	$"..".start_game()
	queue_free()
