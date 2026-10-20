
extends Control
class_name MobileControls

signal accelerate_changed(value: float)
signal reverse_changed(value: float)
signal steering_changed(value: float)
signal brake_changed(value: bool)
signal handbrake_changed(value: bool)
signal nitro_changed(value: bool)

var accelerate_pressed: bool = false
var reverse_pressed: bool = false
var brake_pressed: bool = false
var handbrake_pressed: bool = false
var nitro_pressed: bool = false
var steering_value: float = 0.0


func set_accelerate(pressed: bool) -> void:
    accelerate_pressed = pressed
    accelerate_changed.emit(1.0 if pressed else 0.0)


func set_reverse(pressed: bool) -> void:
    reverse_pressed = pressed
    reverse_changed.emit(1.0 if pressed else 0.0)


func set_steering(value: float) -> void:
    steering_value = clampf(value, -1.0, 1.0)
    steering_changed.emit(steering_value)


func set_brake(pressed: bool) -> void:
    brake_pressed = pressed
    brake_changed.emit(pressed)


func set_handbrake(pressed: bool) -> void:
    handbrake_pressed = pressed
    handbrake_changed.emit(pressed)


func set_nitro(pressed: bool) -> void:
    nitro_pressed = pressed
    nitro_changed.emit(pressed)


func release_all_controls() -> void:
    set_accelerate(false)
    set_reverse(false)
    set_steering(0.0)
    set_brake(false)
    set_handbrake(false)
    set_nitro(false)
