extends Node
class_name NitroController

signal nitro_changed(amount: float)
signal nitro_activated
signal nitro_depleted

@export var max_nitro: float = 100.0
@export var drain_rate: float = 30.0
@export var recharge_rate: float = 12.0
@export var speed_boost: float = 1.5

var nitro_amount: float = 100.0
var nitro_active: bool = false


func _process(delta: float) -> void:
    if nitro_active and nitro_amount > 0.0:
        nitro_amount = maxf(
            0.0,
            nitro_amount - drain_rate * delta
        )

        if nitro_amount <= 0.0:
            nitro_active = false
            nitro_depleted.emit()
    elif not nitro_active:
        nitro_amount = minf(
            max_nitro,
            nitro_amount + recharge_rate * delta
        )

    nitro_changed.emit(nitro_amount)


func activate_nitro() -> void:
    if nitro_amount <= 0.0 or nitro_active:
        return

    nitro_active = true
    nitro_activated.emit()


func deactivate_nitro() -> void:
    nitro_active = false


func get_speed_multiplier() -> float:
    if nitro_active and nitro_amount > 0.0:
        return speed_boost

    return 1.0


func reset_nitro() -> void:
    nitro_amount = max_nitro
    nitro_active = false
    nitro_changed.emit(nitro_amount)
