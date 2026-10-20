еxtends Node
class_name LeaderboardManager

signal record_updated(track_id: String, best_time: float)

const SAVE_PATH: String = "user://shadow_gt_records.json"

var records: Dictionary = {}


func _ready() -> void:
    load_records()


func submit_time(track_id: String, race_time: float) -> bool:
    if track_id.is_empty() or race_time <= 0.0:
        return false

    if not records.has(track_id):
        records[track_id] = race_time
        save_records()
        record_updated.emit(track_id, race_time)
        return true

    var best_time: float = float(records[track_id])

    if race_time < best_time:
        records[track_id] = race_time
        save_records()
        record_updated.emit(track_id, race_time)
        return true

    return false


func get_best_time(track_id: String) -> float:
    return float(records.get(track_id, 0.0))


func load_records() -> void:
    if not FileAccess.file_exists(SAVE_PATH):
        records = {}
        return

    var file := FileAccess.open(SAVE_PATH, FileAccess.READ)

    if file == null:
        records = {}
        return

    var parsed: Variant = JSON.parse_string(file.get_as_text())
    file.close()

    if parsed is Dictionary:
        records = parsed
    else:
        records = {}


func save_records() -> bool:
    var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)

    if file == null:
        return false

    file.store_string(JSON.stringify(records, "\t"))
    file.close()
    return true


func clear_records() -> void:
    records.clear()
    save_records()
