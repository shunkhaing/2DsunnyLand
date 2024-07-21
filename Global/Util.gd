extends Node


const SAVE_PATH = "res://savegame.bin"


func saveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data = {
		"playerHp": Game.playerHp,
		"Gold": Game.Gold,
		"playerX": Game.playerX,
		"playerY": Game.playerY
	}
	
	var jstr = JSON.stringify(data) #take the Dictionary and stringisy it
	file.store_line(jstr)#store it
	
func loadGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH) == true:
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())#current will take all the things in the file and convert it into smth godot readable
			if current_line:
				Game.playerHp = current_line["playerHp"]
				Game.Gold = current_line["Gold"]
				Game.playerX = current_line["playerX"]
				Game.playerY = current_line["playerY"]
