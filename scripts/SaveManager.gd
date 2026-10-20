
extends Node
class_name SaveManager

const SAVE_PATH: String = "user://shadow_gt_save.json"

func save_game(money: int, selected_car: String) -> bool:
    var save_data: Dictionary = {
        "version": 1,
        "money": maxi(0, money),
        "selected_car": selected_car,
        "last_saved": Time.get_datetime_string_from_system()
    }

    var file: FileAccess = FileAccess.open(
        SAVE_PATH,
        FileAccess.WRITE
    )

    if file == null:
        push_error("SHADOW GT: Save file could not be opened.")
        return false

    file.store_string(JSON.stringify(save_data, "\t"))
    file.close()
    return true


func load_game() -> Dictionary:
    if not FileAccess.file_exists(SAVE_PATH):
        return _default_save()

    var file: FileAccess = FileAccess.open(
        SAVE_PATH,
        FileAccess.READ
    )

    if file == null:
        return _default_save()

    var content: String = file.get_as_text()
    file.close()

    var parsed: Variant = JSON.parse_string(content)

    if typeof(parsed) != TYPE_DICTIONARY:
        return _default_save()

    var data: Dictionary = parsed

    return {
        "money": maxi(0, int(data.get("money", 5000))),
        "selected_car": str(data.get("selected_car", "shadow_gt"))
    }


func delete_save() -> bool:
    if not FileAccess.file_exists(SAVE_PATH):
        return true

    return DirAccess.remove_absolute(
        ProjectSettings.globalize_path(SAVE_PATH)
    ) == OK


func _default_save() -> Dictionary:
    return {
        "money": 5000,
        "selected_car": "shadow_gt"
    }
