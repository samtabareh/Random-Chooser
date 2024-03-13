extends CanvasLayer

var Config_Path = "user://config.ini"
var Global_Config_Path = ProjectSettings.globalize_path(Config_Path)
var Files := []

var Extensions := []
var open_file_folder : bool
var open_config : bool

func _ready():
	load_config()

func _on_dir_selected(path: String):
	Files = []
	print_rich("[color=yellow]Selected folder: [/color][color=green]%s[/color]" %path)
	
	var dir = DirAccess.open(path)
	dir = open_dir(dir)
	
	if Files.is_empty():
		print_rich("[color=red]No files with appropriate extension found. Maybe you should add your extensions in the config file[/color]")
		return
	
	var file = Files.pick_random()
	
	print_rich("[color=yellow]Opening file: [/color][color=purple]%s[/color]" %file)
	
	OS.shell_open(file)
	if open_file_folder: OS.shell_show_in_file_manager(file)

func open_dir(dir : DirAccess):
	if !dir: print_rich("[color=red]An error occurred when trying to access the path.
	Error: "+str(DirAccess.get_open_error())+ "[/color]")
	
	var path = dir.get_current_dir()
	
	dir.list_dir_begin()
	var file_name = dir.get_next()
	
	while file_name != "":
		if dir.current_is_dir():
			print_rich("[color=cyan]%s[/color]" % file_name)
			open_dir(DirAccess.open(path+"/"+file_name))
		else:
			if Extensions.has(file_name.get_extension()):
				Files.append(path+"/"+file_name)
		file_name = dir.get_next()

func load_config():
	var config = ConfigFile.new()
	
	if !FileAccess.file_exists(Config_Path):
		config.set_value("Random Chooser", "Extensions", ["mp4", "mp3", "mkv"])
		config.set_value("Random Chooser", "open_file_folder", true)
		config.set_value("Random Chooser", "open_config", false)
		config.save(Config_Path)
		print_rich("[color=yellow]Made config file[/color]")
	
	var err = config.load(Config_Path)
	if err != OK:
		printerr(err)
	
	for section in config.get_sections(): for key in config.get_section_keys(section):
		if key == "Extensions":
			Extensions = config.get_value(section, key)
		if key == "open_file_folder":
			open_file_folder = config.get_value(section, key)
		if key == "open_config":
			open_config = config.get_value(section, key)
			$Config.text = "Open Config" if open_config else "Open Config Folder"
	
	print_rich("[color=yellow]Loaded config file[/color]")

func _on_select_pressed():
	print("[color=yellow]Selecting folder...[/color]")
	$Select/NativeFileDialog.show()

func _on_config_pressed():
	if !open_config:
		print_rich("[color=yellow]Opened config folder[/color]")
		OS.shell_show_in_file_manager(Global_Config_Path)
	else:
		print_rich("[color=yellow]Opened config file[/color]")
		OS.shell_open(Global_Config_Path)

func _on_reload_pressed():
	load_config()

func _on_delete_pressed():
	$Delete/NativeConfirmationDialog.show()

func _on_delete_confirmed():
	DirAccess.remove_absolute(Config_Path)
	print_rich("[color=yellow]Deleted config file[/color]")
