
extends Node
class_name TrackManager

signal track_selected(track_id: String)

var tracks: Dictionary = {
    "city": {
        "name": "City Night",
        "description": "Мусобиқа дар шаҳри шабона",
        "laps": 3,
        "road_width": 12.0
    },
    "mountain": {
        "name": "Mountain Run",
        "description": "Роҳи кӯҳӣ бо гардишҳои тез",
        "laps": 3,
        "road_width": 10.0
    },
    "desert": {
        "name": "Desert Highway",
        "description": "Роҳи дарози биёбон",
        "laps": 2,
        "road_width": 14.0
    },
    "night": {
        "name": "Midnight Circuit",
        "description": "Трассаи шабонаи мусобиқа",
        "laps": 5,
        "road_width": 12.0
    }
}

var selected_track: String = "city"


func select_track(track_id: String) -> bool:
    if not tracks.has(track_id):
        return false

    selected_track = track_id
    track_selected.emit(track_id)
    return true


func get_selected_track() -> Dictionary:
    return tracks.get(selected_track, {}).duplicate(true)


func get_all_tracks() -> Dictionary:
    return tracks.duplicate(true)


func get_track_name(track_id: String) -> String:
    var track: Dictionary = tracks.get(track_id, {})
    return str(track.get("name", "Unknown Track"))


func get_track_laps(track_id: String) -> int:
    var track: Dictionary = tracks.get(track_id, {})
    return int(track.get("laps", 3))


func get_track_width(track_id: String) -> float:
    var track: Dictionary = tracks.get(track_id, {})
    return float(track.get("road_width", 12.0))
