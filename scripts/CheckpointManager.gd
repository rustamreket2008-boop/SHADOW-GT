extends Node
class_name CheckpointManager

signal checkpoint_reached(checkpoint_index: int)
signal all_checkpoints_reached

@export var total_checkpoints: int = 4

var next_checkpoint: int = 0
var checkpoint_count: int = 0


func register_checkpoint(checkpoint_index: int) -> void:
    if checkpoint_index != next_checkpoint:
        return

    checkpoint_count += 1
    next_checkpoint += 1

    checkpoint_reached.emit(checkpoint_index)

    if checkpoint_count >= total_checkpoints:
        all_checkpoints_reached.emit()
        reset_checkpoints()


func reset_checkpoints() -> void:
    next_checkpoint = 0
    checkpoint_count = 0


func is_checkpoint_next(checkpoint_index: int) -> bool:
    return checkpoint_index == next_checkpoint
