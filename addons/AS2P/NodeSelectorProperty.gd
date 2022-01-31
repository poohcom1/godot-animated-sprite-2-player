# RandomIntEditor.gd
extends EditorProperty

var anim_player: AnimationPlayer

# The main control for editing the property.
var drop_down := OptionButton.new()

func get_animatedsprite() -> AnimatedSprite:
	var root = get_tree().edited_scene_root
	return _get_animated_sprites(root)[drop_down.selected]

func _get_animated_sprites(root: Node) -> Array:
	var asNodes := []
	
	for child in root.get_children():
		asNodes += _get_animated_sprites(child)
		
	if root is AnimatedSprite:
		asNodes.append(root)
		
	return asNodes

func _init(_anim_player: AnimationPlayer):
	anim_player = _anim_player
	
	drop_down.clip_text = true
	# Add the control as a direct child of EditorProperty node.
	add_child(drop_down)
	# Make sure the control is able to retain the focus.
	add_focusable(drop_down)
	
	drop_down.clear()
	
func _ready():
	get_items()
	

func get_items():
	drop_down.clear()
	
	var root = get_tree().edited_scene_root
	var anim_players := _get_animated_sprites(root)
	
	for i in range(len(anim_players)):
		var anim_player = anim_players[i]

		drop_down.add_item(root.get_path_to(anim_player), i)
		
func convert_sprites(override=false):
	var animated_sprite: AnimatedSprite = get_node(get_animatedsprite().get_path())
	
	var count = 0
	
	var sprite_frames := animated_sprite.frames
	
	for anim in sprite_frames.get_animation_names():
		var frame_count = sprite_frames.get_frame_count(anim)
		var fps = sprite_frames.get_animation_speed(anim)
		
		if add_animation(
			anim_player.get_node(anim_player.root_node).get_path_to(animated_sprite), 
			anim, 
			frame_count, 
			fps,
			override):
				
			count += 1
			
	print("[AS2P] Added %d animations!" % count)
			
			
func add_animation(anim_sprite: NodePath, anim: String, count: int, fps: float, replace=false):
	print(anim_sprite)
	
	if anim_player.has_animation(anim):
		if not replace:
			return false
		else:
			anim_player.remove_animation(anim)
			
	var animation := Animation.new()
	
	var spf = 1/fps
	
	var frame_track = animation.add_track(Animation.TYPE_VALUE, 0)
	var anim_track = animation.add_track(Animation.TYPE_VALUE, 1)
	
	animation.track_set_path(anim_track, "%s:animation" % anim_sprite)
	animation.track_insert_key(anim_track, 0, anim)
	
	animation.track_set_path(frame_track, "%s:frame" % anim_sprite)
	
	for i in range(count):
		animation.track_insert_key(frame_track, i * spf, i)
		
	anim_player.add_animation(anim, animation)

	return true
