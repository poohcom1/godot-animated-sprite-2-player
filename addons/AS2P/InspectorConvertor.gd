extends EditorInspectorPlugin

const NodeSelectorProperty = preload("./NodeSelectorProperty.gd")

var node_selector: NodeSelectorProperty

# Properties
var animation_player: AnimationPlayer

func can_handle(object):
	if object is AnimationPlayer:
		animation_player = object
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

	var node_selector := NodeSelectorProperty.new(animation_player)
	node_selector.label = "AnimatedSprite Node"
	
	add_custom_control(node_selector)
	
	var button := Button.new()
	button.text = "Import"
	button.connect("button_down", node_selector, "convert_sprites")
	
	add_custom_control(button)
