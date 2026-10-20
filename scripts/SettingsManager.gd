extends Node
class_name SettingsManager

signal settings_changed

const SAVE_PATH: String = "user://shadow_gt_settings.json"

var master_volume: float = 1.0
var music_volume: float = 0.7
var engine_volume: float = 0.8
var steering_sensitivity: float = 1.0
var graphics_quality: int = 2


func set_master_volume(value: float) -> void:
    master_volume = clampf(value, 0.0, 1.0)
    _apply_audio()
    settings_changed.emit()


func set_music_volume(value: float) -> void:
    music_volume = clampf(value, 0.0, 1.0)
    settings_changed.emit()


func set_engine_volume(value: float) -> void:
    engine_volume = clampf(value, 0.0, 1.0)
    settings_changed.emit()


func set_steering_sensitivity(value: float) -> void:
    steering_sensitivity = clampf(value, 0.2, 2.0)
    settings_changed.emit()


func set_graphics_quality(value: int) -> void:
    graphics_quality = clampi(value, 0, 2)
    settings_changed.emit()


func _apply_audio() -> void:
    var bus_index := AudioServer.get_bus_index("Master")

    if bus_index >= 0:
        AudioServer.set_bus_volume_linear(
            bus_index,
            master_volume
        )


func save_settings() -> bool:
    var data := {
        "master_volume": master_volume,
        "music_volume": music_volume,
        "engine_volume": engine_volume,
        "steering_sensitivity": steering_sensitivity,
        "graphics_quality": graphics_quality
    }

    var file := FileAccess.open(
        SAVE_PATH,
        FileAccess.WRITE
    )

    if file == null:
        return false

    file.store_string(JSON.stringify(data, "\t"))
    file.close()
    return true


func load_settings() -> void:
    if not FileAccess.file_exists(SAVE_PATH):
        _apply_audio()
        return

    var file := FileAccess.open(
        SAVE_PATH,
        FileAccess.READ
    )

    if file == null:
        return

    var parsed: Variant = JSON.parse_string(
        file.get_as_text()
    )
    file.close()

    if not parsed is Dictionary:
        return

    master_volume = clampf(
        float(parsed.get("master_volume", 1.0)),
        0.0, 1.0
    )
    music_volume = clampf(
        float(parsed.get("music_volume", 0.7)),
        0.0, 1.0
    )
    engine_volume = clampf(
        float(parsed.get("engine_volume", 0.8)),
        0.0, 1.0
    )
    steering_sensitivity = clampf(
        float(parsed.get("steering_sensitivity", 1.0)),
        0.2, 2.0
    )
    graphics_quality = clampi(
        int(parsed.get("graphics_quality", 2)),
        0, 2
    )

    _apply_audio()
    settings_changed.emit()
