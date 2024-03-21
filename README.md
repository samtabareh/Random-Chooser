## Instructions
1. Download the latest [release](https://github.com/samtabareh/Random-Chooser/releases/latest)
2. Unzip it (optional)
3. Run the exe

## Config File
| Property | Value | Description |
| :------- | :---: | :---------- |
| `extensions` | Array[String] | Array of all allowed and filtered extensions for files to be included or filtered out |
| `open_file_folder` | bool | If true the folder of the chosen file will open |
| `open_config` | bool | If false the folder of the config will open instead of the file |

### Extensions
`extensions` can allow all extentions by adding the "any" string to it. And it can have extensions that'll be filtered out and wont be included by adding ! + the filtered extension. Check examples for more clarity.

### Examples

**This config will allow mp4 files and png files to be included but not jpeg files. It'll also open the containing folder of the randomly opened file and the config button will open the config file when clicked instead of the configs containing folder.**
```EditorConfig
extensions=["mp4", "png", "jpeg", "!jpeg"]
open_file_folder=true
open_config=true
```

**This config will allow any file except png files to be included. It won't open the containing folder of the randomly opened file. The config button will open the config file when clicked instead of the configs containing folder.**
```EditorConfig
extensions=["any", "!png"]
open_file_folder=false
open_config=true
```