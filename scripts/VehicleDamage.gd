extends Node
class_name VehicleDamage

signal health_changed(current_health: float, max_health: float)
signal vehicle_disabled

@export var max_health: float = 100.0
@export var damage_per_crash: float = 25.0

var current_health: float = 100.0
var disabled: bool = false


func _ready() -> void:
    current_health = max_health
    health_changed.emit(current_health, max_health)


func apply_damage(amount: float) -> void:
    if disabled or amount <= 0.0:
        return

    current_health = maxf(0.0, current_health - amount)
    health_changed.emit(current_health, max_health)

    if current_health <= 0.0:
        disabled = true
        vehicle_disabled.emit()


func apply_crash_damage() -> void:
    apply_damage(damage_per_crash)


func repair_vehicle(amount: float) -> void:
    if amount <= 0.0:
        return

    current_health = minf(max_health, current_health + amount)

    if current_health > 0.0:
        disabled = false

    health_changed.emit(current_health, max_health)


func repair_fully() -> void:
    current_health = max_health
    disabled = false
    health_changed.emit(current_health, max_health)


func get_health_ratio() -> float:
    if max_health <= 0.0:
        return 0.0

    return current_health / max_health
