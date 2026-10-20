extends Node
class_name WeatherManager

signal weather_changed(weather_name: String)

enum Weather {
    SUNNY,
    CLOUDY,
    RAINY,
    FOGGY
}

var current_weather: Weather = Weather.SUNNY


func set_weather(new_weather: Weather) -> void:
    if new_weather == current_weather:
        return

    current_weather = new_weather
    weather_changed.emit(get_weather_name())


func set_random_weather() -> void:
    var choices: Array[Weather] = [
        Weather.SUNNY,
        Weather.CLOUDY,
        Weather.RAINY,
        Weather.FOGGY
    ]

    var next_weather: Weather = choices[
        randi_range(0, choices.size() - 1)
    ]

    set_weather(next_weather)


func get_weather_name() -> String:
    match current_weather:
        Weather.SUNNY:
            return "Офтобӣ"
        Weather.CLOUDY:
            return "Абрнок"
        Weather.RAINY:
            return "Боронӣ"
        Weather.FOGGY:
            return "Туман"
        _:
            return "Номаълум"


func get_weather_color() -> Color:
    match current_weather:
        Weather.SUNNY:
            return Color(0.45, 0.68, 0.95)
        Weather.CLOUDY:
            return Color(0.35, 0.40, 0.48)
        Weather.RAINY:
            return Color(0.18, 0.23, 0.32)
        Weather.FOGGY:
            return Color(0.55, 0.58, 0.62)
        _:
            return Color(0.45, 0.68, 0.95)
