extends Control

var GAME = load("uid://dosm4qiu40ok5")
var MAIN = load("uid://bvbc42wpy3yx5")

func _on_start_button_pressed() -> void:
	SceneSwitcher.goto_scene(MAIN, "")
