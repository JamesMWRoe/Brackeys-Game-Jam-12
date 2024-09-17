extends Resource
class_name Item

enum item_types {UPGRADE, CONSUMABLE}

@export var type: item_types
@export var name: String
@export var icon: Texture2D
@export var description: String
@export var cost: int
@export var effect: BaseItemEffect
