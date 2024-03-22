extends Node

### GLOBAL VARS
var Config_Path = "user://config.ini"
var Global_Config_Path = ProjectSettings.globalize_path(Config_Path)
var Selected_Path: String
var Files:= []

### CONFIG VARS 
var versions:= {}
var old_extensions:= []
var Extensions:= []
var load_inside_folders: bool
var open_file_folder: bool
var open_config: bool

### CONSTANTS
## Config Version
const CV = 3
## Filter Key
const FKEY = "!"

func _ready():
	load_config()

### LOADING FILES
func load_dir(path: String):
	Files = []
	Selected_Path = path
	print_rich("[color=yellow]Selected folder: [/color][color=green]%s[/color]" %path)
	
	var dir = DirAccess.open(path)
	dir =  await open_dir(dir)
	print_rich("[color=yellow]Files: [/color][color=orange]%s[/color]"% Files.size())

func open_dir(dir : DirAccess):
	if !dir: print_rich("[color=red]An error occurred when trying to access the path.
	Error: "+str(DirAccess.get_open_error())+ "[/color]")
	
	var path = dir.get_current_dir()
	
	dir.list_dir_begin()
	var file_name = dir.get_next()
	
	while file_name != "":
		if dir.current_is_dir() && load_inside_folders:
			print_rich("[color=cyan]%s[/color]" % file_name)
			open_dir(DirAccess.open(path+"/"+file_name))
		elif !dir.current_is_dir():
			if Extensions.has(FKEY+file_name.get_extension()): return
			elif Extensions.has(file_name.get_extension()) || Extensions.has("any"):
				Files.append(path+"/"+file_name)
		file_name = dir.get_next()

### CONFIG

func load_config():
	var config = ConfigFile.new()
	
	if !FileAccess.file_exists(Config_Path):
		config.set_value("Config", "v",
		{"App": ProjectSettings.get_setting("application/config/version"),
		 "Config": CV})
		config.save(Config_Path)
		print_rich("[color=yellow]Made config file[/color]")
	
	var err = config.load(Config_Path)
	if err != OK:
		printerr(err)
	
	for section in config.get_sections():
		var keys = config.get_section_keys(section)
		
		if keys.has("versions"):
			versions = config.get_value(section, "versions")
		
		if keys.has("extensions"):
			old_extensions = Extensions
			Extensions = config.get_value(section, "extensions")
		else: config.set_value(section, "extensions", ["mp4", "mkv", "!mp3"])
		
		if keys.has("load_inside_folders"):
			load_inside_folders = config.get_value(section, "load_inside_folders")
		else: config.set_value(section, "load_inside_folders", true)
		
		if keys.has("open_file_folder"):
			open_file_folder = config.get_value(section, "open_file_folder")
		else: config.set_value(section, "open_file_folder", false)
		
		if keys.has("open_config"):
			open_config = config.get_value(section, "open_config")
		else: config.set_value(section, "open_config", true)
		
		#config.set_value(section, "av", ProjectSettings.get_setting("application/config/version"))
		#config.set_value(section, "cv", CV)
		config.set_value(section, "v", 
		{"App": ProjectSettings.get_setting("application/config/version"),
		 "Config": CV})
		
		config.save(Config_Path)
	
	for ex in Extensions: if !old_extensions.has(ex) && Selected_Path:
		load_dir(Selected_Path)
	
	print_rich("[color=yellow]Loaded config file[/color]")
