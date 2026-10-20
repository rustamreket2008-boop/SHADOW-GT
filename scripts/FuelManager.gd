extends Node
class_name FuelManager

signal fuel_changed(current_fuel: float, max_fuel: float)
signal fuel_empty

@export var max_fuel: float = 100.0
@export var consumption_rate: float = 0.5

var current_fuel: float = 100.0
var engine_running: bool = true


func _ready() -> void:
    current_fuel = max_fuel
    fuel_changed.emit(current_fuel, max_fuel)


func _process(delta: float) -> void:
    if not engine_running or current_fuel <= 0.0:
        return

    current_fuel = maxf(
        0.0,
        current_fuel - consumption_rate * delta
    )

    fuel_changed.emit(current_fuel, max_fuel)

    if current_fuel <= 0.0:
        engine_running = false
        fuel_empty.emit()


func refuel(amount: float) -> void:
    if amount <= 0.0:
        return

    current_fuel = minf(
        max_fuel,
        current_fuel + amount
    )

    if current_fuel > 0.0:
        engine_running = true

    fuel_changed.emit(current_fuel, max_fuel)


func refuel_completely() -> void:
    current_fuel = max_fuel
    engine_running = true
    fuel_changed.emit(current_fuel, max_fuel)


func get_fuel_ratio() -> float:
    if max_fuel <= 0.0:
        return 0.0

    return current_fuel / max_fuel
