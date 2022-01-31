extends EditorInspectorPlugin

const NodeSelectorProperty = preload("./NodeSelectorProperty.gd")

var node_selector: NodeSelectorProperty

# Properties
var anim_player: AnimationPlayer

# Options
var replace = false

func can_handle(object):
	if object is AnimationPlayer:
		anim_player = object
		
		return true
	return false

func parse_end():
	var headerstyle = StyleBoxFlat.new()
	headerstyle.bg_color = Color8(64, 69, 83)
	
	var header = Label.new()
	header.set("custom_styles/normal", headerstyle)
	header.margin_top = 10
	header.rect_min_size.y = 25
	header.text = "Import AnimatedSprite"
	header.align = Label.ALIGN_CENTER
	header.valign = Label.VALIGN_CENTER
	
	add_custom_control(header)

	node_selector = NodeSelectorProperty.new(anim_player)
	node_selector.label = "AnimatedSprite Node"
	
	add_custom_control(node_selector)
	
	var replace_option := EditorProperty.new()
	replace_option.label = "Replace"
	
	var replace_check := CheckBox.new()
	replace_check.pressed = replace
	node_selector.replace = replace
	replace_check.connect("toggled", self, "_on_replace_set")
	replace_check.connect("toggled", node_selector, "set_override")
	replace_option.add_child(replace_check)
	
	add_custom_control(replace_option)
	
	var button := Button.new()
	button.text = "Import"
	button.connect("button_down", node_selector, "convert_sprites")
	
	add_custom_control(button)


func _on_replace_set(_replace):
	replace = _replace
