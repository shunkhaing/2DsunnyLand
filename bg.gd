extends ParallaxBackground

var scrolling_speed = 100

func _process(delta):
	scroll_offset.x -= scrolling_speed * delta


func _on_button_pressed():
	get_tree().change_scene_to_file("res://pause.tscn")
