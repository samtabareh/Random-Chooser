# Instructions
1. Download the latest [release](https://github.com/samtabareh/Random-Chooser/releases/latest)
2. Unzip it (optional)
3. Run the exe

# Config File
| Property | Value | Description |
| :------- | :---: | :---------- |
| `extensions` | `Array[String]`| Array of all allowed extensions for files to be included |
| `open_file_folder` | `bool` | If true the folder of the chosen file will open |
| `open_config` | `bool` | If false the folder of the config will open instead of the file |
### Example
```EditorConfig
extensions=["mp4", "png"]
open_file_folder=true
open_config=true
```
