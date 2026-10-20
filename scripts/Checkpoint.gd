extends Area3D
class_name RaceCheckpoint

signal checkpoint_reached(checkpoint_index: int)

@export var checkpoint_index: int = 0
@export var next_checkpoint_index: int = 1

var activated: bool = false


func _ready() -> void:
    body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node3D) -> void:
    if activated:
        return

    if not body is CharacterBody3D:
        return

    if body.name != "Car":
        return

    activated = true
    checkpoint_reached.emit(checkpoint_index)


func reset_checkpoint() -> void:
    activated = false


func is_activated() -> bool:
    return activated
