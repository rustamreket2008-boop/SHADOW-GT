extends Node
class_name SaveManager

const SAVE_PATH: String = "user://shadow_gt_save.json"


func save_game(data: Dictionary) -> bool:
    var file := FileAccess.open(
        SAVE_PATH,
        FileAccess.WRITE
    )

    if file == null:
        push_error("SHADOW GT: Save file could not be opened.")
        return false

    file.store_string(JSON.stringify(data, "\t"))
    file.close()
    return true


func load_game() -> Dictionary:
    if not FileAccess.file_exists(SAVE_PATH):
        return {}

    var file := FileAccess.open(
        SAVE_PATH,
        FileAccess.READ
    )

    if file == null:
        return {}

    var content: String = file.get_as_text()
    file.close()

    var parsed: Variant = JSON.parse_string(content)

    if parsed is Dictionary:
        return parsed

    return {}


func delete_save() -> bool:
    if not FileAccess.file_exists(SAVE_PATH):
        return true

    var absolute_path: String = ProjectSettings.globalize_path(
        SAVE_PATH
    )

    var error: Error = DirAccess.remove_absolute(absolute_path)
    return error == OK
