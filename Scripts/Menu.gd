extends CanvasLayer

func _process(_delta):
	$VBoxContainer/Open.disabled = Main.Files.size() == 0
	$Files.text = "[color=yellow]Files Loaded: [/color][color=green]%s"% Main.Files.size()

func _on_select_pressed():
	$VBoxContainer/Select.release_focus()
	$VBoxContainer/Select/NativeFileDialog.show()

func _on_dir_selected(path: String):
	$VBoxContainer/Open.disabled = true
	await Main.load_dir(path)
	$VBoxContainer/Open.disabled = false

func _on_open_pressed():
	$VBoxContainer/Open.release_focus()
	if Main.Files.is_empty():
		print_rich("[color=red]No files with appropriate extension found. Maybe you should add your extensions in the config file[/color]")
		return
	
	var file = Main.Files.pick_random()
	if Main.Extensions.has("!"+file.get_extension()):
		print_rich("[color=red]Selected file had a filtered extension. [b]Please Try Again[/b][/color]")
		Main.Files.erase(file)
		return
	
	print_rich("[color=yellow]Opening file: [/color][color=purple]%s[/color]" %file)
	
	OS.shell_open(file)
	if Main.open_file_folder: OS.shell_show_in_file_manager(file)

func _on_settings_pressed():
	get_tree().change_scene_to_file("res://Scenes/Config.tscn")
