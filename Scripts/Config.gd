extends CanvasLayer

func _process(_delta):
	$VBoxContainer/Delete.disabled = !FileAccess.file_exists(Main.Config_Path)
	$VBoxContainer/Config.text = "Open Config" if Main.open_config else "Open Config Folder"

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")

func _on_config_pressed():
	$VBoxContainer/Config.release_focus()
	if !Main.open_config:
		print_rich("[color=yellow]Opened config folder[/color]")
		OS.shell_open(ProjectSettings.globalize_path("user://"))
	else:
		print_rich("[color=yellow]Opened config file[/color]")
		OS.shell_open(Main.Global_Config_Path)

func _on_reload_pressed():
	$VBoxContainer/Reload.release_focus()
	Main.load_config()

func _on_delete_pressed():
	$VBoxContainer/Delete.release_focus()
	$VBoxContainer/Delete/Delete.show()

func _on_delete_confirmed():
	DirAccess.remove_absolute(Main.Config_Path)
	print_rich("[color=yellow]Deleted config file[/color]")
