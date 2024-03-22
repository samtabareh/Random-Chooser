# Install
1. Download the latest [release](https://github.com/samtabareh/Random-Chooser/releases/latest)
2. Unzip it (optional)
3. Run the exe

# Instructions
1. After opening the app, click on "Open Config" to customize your settings. **(Make sure to remember to click on "Reload Config" for your changes to appear whenever you edit the config)**
2. Then click on "Select A Folder" and select the desired folder that you want to open random files from.
3. Click on "Open A Random File" for a random file to be opened.

# Config File
| Property | Value Type | Default Value | | Description |
| :------- | :--------: | :-----------: | :------------ |
| `extensions` | Array[String] | ["mp4", "mkv", "!mp3"] | Array of all allowed and filtered extensions for files to be included or filtered out |
| `load_inside_folders` | bool | `true` | If true the app will load the folders inside of the selected folder |
| `open_file_folder` | bool | `false` | If true the folder of the chosen file will open |
| `open_config` | bool | `true` | If false the folder of the config will open instead of the file |

### `extensions` Values
`extensions` can allow all extensions by adding the "any" string to it. And it can have extensions that'll be filtered out and wont be included by adding "! + the filtered extension". Check examples for more clarity.

## Examples

**This config will allow mp4 and png files to be included. It'll also make the app load the files inside of the folders within the selected folder. And the app will open the containing folder of the randomly opened file. The config button will open the config file when clicked instead of the configs containing folder.**
```EditorConfig
v={
"App": "1.4.2",
"Config": 3
}
extensions=["mp4", "png"]
load_inside_folders=true
open_file_folder=true
open_config=true
```
**This config will allow any file except png files to be included. The app wont load the folders inside the selected folder, only the files in the selected folder. The app won't open the containing folder of the randomly opened file. The config button will open the config file when clicked instead of the configs containing folder.**
```EditorConfig
v={
"App": "1.4.2",
"Config": 3
}
extensions=["any", "!png"]
load_inside_folders=false
open_file_folder=false
open_config=true
```
