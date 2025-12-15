extends Resource

class_name BaseTrait

@export_group("General Details")
@export var name : String
@export var icon : Texture2D
@export_multiline var description : String

@export_group("Speed Trait")
@export var speed_factor : float = 1.0

@export_group("Explosion Trait")
@export var can_explode : bool = false
@export var explode_on_floor : bool = false
## Counts number of times required to bounc on floor until explosion.
@export var bounce_mod : int = 1
@export var explode_on_enemy : bool = false
