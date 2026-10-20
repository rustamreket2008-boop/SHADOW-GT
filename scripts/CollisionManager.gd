
extends Node

signal collision_detected(other: Node)
signal crash_effect_requested

var collisions_enabled: bool = true
var last_collision_time: float = -10.0
@export var collision_cooldown: float = 1.0


func report_collision(other: Node) -> void:
    if not collisions_enabled:
        return

    var now := Time.get_ticks_msec() / 1000.0

    if now - last_collision_time < collision_cooldown:
        return

    last_collision_time = now

    collision_detected.emit(other)
    crash_effect_requested.emit()


func enable_collisions() -> void:
    collisions_enabled = true


func disable_collisions() -> void:
    collisions_enabled = false


func reset_collisions() -> void:
    last_collision_time = -10.0
    collisions_enabled = true
