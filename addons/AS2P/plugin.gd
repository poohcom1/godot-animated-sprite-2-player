tool
extends EditorPlugin

const Convertor = preload("res://addons/AS2P/InspectorConvertor.gd")

var plugin: EditorInspectorPlugin

func _enter_tree():
	plugin = load("res://addons/AS2P/InspectorConvertor.gd").new()
	add_inspector_plugin(plugin)


func _exit_tree():
	remove_inspector_plugin(plugin)

var anim_sprite: AnimatedSprite
var anim_player: AnimationPlayer
