extends Node3D

@export var toggled : bool = false
@export var message_on : String = "Button pressed."
@export var message_off : String = "Button unpressed."

func _ready():
	%InteractableComponent.interacted.connect(on_interacted)
	%HurtboxComponent.damage_taken.connect(on_damage_taken)

func on_interacted(_source:Node3D):
	toggled = !toggled
	$Model/CSGCylinder3D.position.y = 0.15 + (0.0 if toggled else 0.1)
	if toggled:
		print_debug(message_on, " ", self)
	else:
		print_debug(message_off, " ", self)
	ConfigManager.set_config("is_fullscreen", toggled)

func on_damage_taken(_amount):
	on_interacted(null)

func _process(_delta):
	%HighlightMesh.visible = !!%InteractableComponent.get_character_hovering_current_camera()
