extends Node
class_name MissionManager

signal mission_progress_changed(mission_id: String, progress: int)
signal mission_completed(mission_id: String, reward: int)

var missions: Dictionary = {
    "drive_1km": {
        "title": "1 км рондан",
        "target": 1000,
        "progress": 0,
        "reward": 500,
        "completed": false
    },
    "reach_100": {
        "title": "Суръат ба 100 км/соат",
        "target": 100,
        "progress": 0,
        "reward": 750,
        "completed": false
    },
    "drive_5km": {
        "title": "5 км рондан",
        "target": 5000,
        "progress": 0,
        "reward": 2000,
        "completed": false
    }
}


func add_progress(mission_id: String, amount: int) -> void:
    if amount <= 0 or not missions.has(mission_id):
        return

    var mission: Dictionary = missions[mission_id]

    if mission["completed"]:
        return

    mission["progress"] = mini(
        int(mission["progress"]) + amount,
        int(mission["target"])
    )

    mission_progress_changed.emit(
        mission_id,
        int(mission["progress"])
    )

    if int(mission["progress"]) >= int(mission["target"]):
        mission["completed"] = true
        mission_completed.emit(
            mission_id,
            int(mission["reward"])
        )


func get_mission(mission_id: String) -> Dictionary:
    if not missions.has(mission_id):
        return {}

    return missions[mission_id].duplicate()


func get_all_missions() -> Dictionary:
    return missions.duplicate(true)


func reset_missions() -> void:
    for mission_id in missions:
        missions[mission_id]["progress"] = 0
        missions[mission_id]["completed"] = false
