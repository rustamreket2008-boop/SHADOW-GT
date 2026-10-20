
extends Node
class_name WeatherSystem

signal weather_changed(weather_name: String)
signal time_changed(hour: float)

enum WeatherType {
    SUNNY,
    CLOUDY,
    RAINY,
    NIGHT
}

var current_weather: WeatherType = WeatherType.SUNNY
var current_hour: float = 14.0
var time_speed: float = 0.1

var world_environment: WorldEnvironment
var sun_light: DirectionalLight3D


func _process(delta: float) -> void:
    current_hour = fposmod(
        current_hour + time_speed * delta,
        24.0
    )

    time_changed.emit(current_hour)
    _update_lighting()


func set_weather(weather: WeatherType) -> void:
    current_weather = weather
    _update_lighting()
    weather_changed.emit(get_weather_name())


func set_time(hour: float) -> void:
    current_hour = fposmod(hour, 24.0)
    _update_lighting()
    time_changed.emit(current_hour)


func get_weather_name() -> String:
    match current_weather:
        WeatherType.SUNNY:
            return "Sunny"
        WeatherType.CLOUDY:
            return "Cloudy"
        WeatherType.RAINY:
            return "Rainy"
        WeatherType.NIGHT:
            return "Night"

    return "Unknown"


func _update_lighting() -> void:
    var is_night: bool = (
        current_weather == WeatherType.NIGHT
        or current_hour < 6.0
        or current_hour >= 19.0
    )

    if is_instance_valid(sun_light):
        sun_light.light_energy = 0.15 if is_night else 1.0

        if current_weather == WeatherType.CLOUDY:
            sun_light.light_energy *= 0.65
        elif current_weather == WeatherType.RAINY:
            sun_light.light_energy *= 0.4

        sun_light.rotation_degrees.x = (
            (current_hour / 24.0) * 360.0 - 90.0
        )

    if is_instance_valid(world_environment):
        var env: Environment = world_environment.environment

        if env != null:
            if is_night:
                env.background_color = Color(0.015, 0.025, 0.08)
            elif current_weather == WeatherType.RAINY:
                env.background_color = Color(0.22, 0.27, 0.34)
            elif current_weather == WeatherType.CLOUDY:
                env.background_color = Color(0.4, 0.43, 0.48)
            else:
                env.background_color = Color(0.45, 0.68, 0.95)
