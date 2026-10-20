extends Node
class_name AchievementManager

signal achievement_unlocked(id: String, title: String)

var achievements: Dictionary = {
    "first_race": {
        "title": "🏁 Гонкаи аввал",
        "description": "Аввалин гонкаро анҷом деҳ",
        "unlocked": false
    },
    "speed_100": {
        "title": "⚡ Суръати 100",
        "description": "Ба суръати 100 км/соат рас",
        "unlocked": false
    },
    "drift_master": {
        "title": "🔥 Устоди дрифт",
        "description": "1000 хол дрифт гир",
        "unlocked": false
    },
    "road_king": {
        "title": "👑 Подшоҳи роҳ",
        "description": "5000 хол ҷамъ кун",
        "unlocked": false
    }
}


func unlock_achievement(id: String) -> void:
    if not achievements.has(id):
        return

    if achievements[id]["unlocked"]:
        return

    achievements[id]["unlocked"] = true

    achievement_unlocked.emit(
        id,
        achievements[id]["title"]
    )


func is_unlocked(id: String) -> bool:
    if not achievements.has(id):
        return false

    return achievements[id]["unlocked"]


func get_all_achievements() -> Dictionary:
    return achievements.duplicate(true)


func reset_achievements() -> void:
    for id in achievements:
        achievements[id]["unlocked"] = false
