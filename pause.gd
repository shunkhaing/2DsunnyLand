extends Node2D


func _on_resume_pressed():
	get_tree().change_scene_to_file("res://world.tscn")
	Game.playerX = Game.playerX
	Game.playerY = Game.playerY


func _on_restart_pressed():
	Game.playerHp = Game.HP
	Game.Gold = Game.G
	get_tree().change_scene_to_file("res://world.tscn")

func _on_quit_pressed():
	get_tree().quit()
