extends Control

class_name Inventory

const SPEED_1 : BaseTrait = preload("uid://mmmtiwdic1o6")
const SPEED_2 : BaseTrait = preload("uid://ce7ge7vklf1ln")

@onready var inventory_background := $Background/InvenBackground
@onready var inventory_items := $Background/ItemLayer

func _ready() -> void:
	#DEBUG STUFF
	Gamestate.player_traits[SPEED_1] = 1
	Gamestate.player_traits[SPEED_2] = 1
	set_background_squares(27)
	fill_inventory_place_squares()
	self.visible = false
	Gamestate.inventory_state = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("toggle_inventory"):
		self.visible = not self.visible
		Gamestate.inventory_state = self.visible

func set_background_squares(n : int):
	for child in inventory_background.get_children():
		child.queue_free()
	for i in range(n):
		var temp_square := ColorRect.new()
		temp_square.color = Color(0.73, 0.771, 0.785, 1.0)
		temp_square.custom_minimum_size = inventory_background.custom_minimum_size
		inventory_background.add_child(temp_square)

func _on_item_icon_input(event: InputEvent, base_trait : BaseTrait):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		Gamestate.player_traits[base_trait] -= 1
		Gamestate.ball_1_active_traits.append(base_trait)
		fill_inventory_place_squares()
		fill_ball_player_traits()

func fill_ball_player_traits():
	for child in $Background/Ball1/Ball1Traits.get_children():
		child.queue_free()
	for base_trait : BaseTrait in Gamestate.ball_1_active_traits:
		var icon_square := TextureRect.new()
		icon_square.texture = base_trait.icon
		icon_square.custom_minimum_size = inventory_items.custom_minimum_size
		icon_square.gui_input.connect(_on_item_icon_input.bind(base_trait))
		$Background/Ball1/Ball1Traits.add_child(icon_square)

func fill_inventory_place_squares():
	for child in inventory_items.get_children():
		child.queue_free()
	for base_trait : BaseTrait in Gamestate.player_traits:
		if Gamestate.player_traits[base_trait] == 0:
			continue
		var icon_square := TextureRect.new()
		icon_square.texture = base_trait.icon
		icon_square.custom_minimum_size = inventory_items.custom_minimum_size
		icon_square.gui_input.connect(_on_item_icon_input.bind(base_trait))
		inventory_items.add_child(icon_square)
