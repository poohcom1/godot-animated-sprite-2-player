@tool
extends EditorInspectorPlugin

const NodeSelectorProperty = preload("./NodeSelectorProperty.gd")

var node_selector: NodeSelectorProperty

# Properties
var anim_player: AnimationPlayer

# Options
var replace = false

# Signals
signal animation_updated(animation_player: AnimationPlayer)

func _can_handle(object: Object) -> bool:
	if object is AnimationPlayer:
		anim_player = object
		return true
		
	return false

func _parse_end(object: Object) -> void:
	var headerstyle = StyleBoxFlat.new()
	headerstyle.bg_color = Color8(64, 69, 83)

	var header := Label.new()
	header.add_theme_stylebox_override("normal", headerstyle)
	header.custom_minimum_size = Vector2(0, 25)
	header.text = "Import AnimatedSprite"
	header.horizontal_alignment = HorizontalAlignment.HORIZONTAL_ALIGNMENT_CENTER
	header.vertical_alignment = VerticalAlignment.VERTICAL_ALIGNMENT_CENTER
	
	add_custom_control(header)

	node_selector = NodeSelectorProperty.new(anim_player)
	node_selector.label = "AnimatedSprite Node"
	
	node_selector.animation_updated.connect(_on_animation_updated)
	
	add_custom_control(node_selector)
	
	var replace_option := ReplaceEditorProp.new()
	replace_option.label = "Replace"
	
	var replace_check := CheckBox.new()
	replace_check.button_pressed = replace
	node_selector.replace = replace
	replace_check.toggled.connect(_on_replace_set)
	replace_check.toggled.connect(node_selector.set_override)
	replace_option.add_child(replace_check)
	
	
	add_custom_control(replace_option)
	
	var button := Button.new()
	button.text = "Import"
	button.custom_minimum_size = Vector2(0, 26)
	
	var buttonstyle = StyleBoxFlat.new()
	buttonstyle.bg_color = Color8(32, 37, 49)
	button.add_theme_stylebox_override("normal", buttonstyle)
	button.pressed.connect(node_selector.convert_sprites)
	
	add_custom_control(button)


func _on_replace_set(_replace: bool) -> void:
	replace = _replace
	
	
func _on_animation_updated() -> void:
	emit_signal("animation_updated", anim_player)

class ReplaceEditorProp extends EditorProperty:
	func _init() -> void:
		super._init()

	func get_tooltip_text() -> String:
		return "If true, replace existing animations."
