
extends RefCounted
class_name NitroSystem

var nitro_amount: float = 100.0
var nitro_capacity: float = 100.0
var nitro_power: float = 20.0
var drain_rate: float = 30.0
var recharge_rate: float = 12.0

func update_nitro(
    active: bool,
    delta: float
) -> float:
    if active and nitro_amount > 0.0:
        nitro_amount -= drain_rate * delta
    else:
        nitro_amount += recharge_rate * delta

    nitro_amount = clampf(
        nitro_amount, 0.0, nitro_capacity
    )

    return nitro_amount

func get_bonus_speed(active: bool) -> float:
    if active and nitro_amount > 0.0:
        return nitro_power

    return 0.0

func refill() -> void:
    nitro_amount = nitro_capacity
