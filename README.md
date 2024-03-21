# Install
1. Download the latest [release](https://github.com/samtabareh/Random-Chooser/releases/latest)
2. Unzip it (optional)
3. Run the exe

# Instructions
1. After opening the app, click on "Open Config" to customize your settings. **(Make sure to remember to click on "Reload Config" for your changes to appear whenever you edit the config)**
2. Then click on "Select A Folder" and select the desired folder that you want to open random files from.
3. Click on "Open A Random File" for a random file to be opened.

# Config File
| Property | Value | Description |
| :------- | :---: | :---------- |
| `extensions` | Array[String] | Array of all allowed and filtered extensions for files to be included or filtered out |
| `open_file_folder` | bool | If true the folder of the chosen file will open |
| `open_config` | bool | If false the folder of the config will open instead of the file |

### Extensions Values
`extensions` can allow all extentions by adding the "any" string to it. And it can have extensions that'll be filtered out and wont be included by adding "! + the filtered extension". Check examples for more clarity.

## Examples

**This config will allow mp4 and png files to be included. It'll also open the containing folder of the randomly opened file and the config button will open the config file when clicked instead of the configs containing folder.**
```EditorConfig
extensions=["mp4", "png"]
open_file_folder=true
open_config=true
```
**This config will allow any file except png files to be included. It won't open the containing folder of the randomly opened file. The config button will open the config file when clicked instead of the configs containing folder.**
```EditorConfig
extensions=["any", "!png"]
open_file_folder=false
open_config=true
```
