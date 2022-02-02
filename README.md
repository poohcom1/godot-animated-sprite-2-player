# Godot AnimatedSprite to AnimationPlayer Convertor
A Godot addon to convert animated sprite frames to animations in an animation player. Adds an extra slot in AnimationPlayers' inspector tab to import sprites from an AnimatedSprite.

![](screenshots/usage-example.gif)

## Installation 
1. Clone this repository or download from the [Godot Asset Library page](https://godotengine.org/asset-library/asset/1216)
2. Copy `addons/AS2P` to your addons folder (or create a new one if you don't have one)
3. Activate the plugin in your Project Settings and you're ready to go!

## Usage
![](screenshots/inspector-addon.png)
1. Select the `AnimationPlayer` node to import the sprites to.
2. In the drop-down, select the path to the AnimatedSprite to import the sprites from.
3. Check "Replace" if you want to replace your existing animations. Otherwise, leave it unchecked to only add new animations. 
  
  *WARNING: Replace will completely overwrite all animations! Make sure you know what you are doing!*
  
4. Click "Import" to convert.
