extends Node
class_name LanguageManager

signal language_changed(language_code: String)

var current_language: String = "tg"

var translations: Dictionary = {
    "menu": {
        "tg": "МЕНЮ",
        "ru": "МЕНЮ",
        "en": "MENU"
    },
    "play": {
        "tg": "Бозӣ",
        "ru": "Играть",
        "en": "Play"
    },
    "garage": {
        "tg": "Гараж",
        "ru": "Гараж",
        "en": "Garage"
    },
    "settings": {
        "tg": "Танзимот",
        "ru": "Настройки",
        "en": "Settings"
    },
    "exit": {
        "tg": "Баромад",
        "ru": "Выход",
        "en": "Exit"
    },
    "speed": {
        "tg": "Суръат",
        "ru": "Скорость",
        "en": "Speed"
    },
    "paused": {
        "tg": "Бозӣ боздошта шуд",
        "ru": "Игра на паузе",
        "en": "Game Paused"
    }
}


func set_language(language_code: String) -> void:
    if not ["tg", "ru", "en"].has(language_code):
        return

    if current_language == language_code:
        return

    current_language = language_code
    language_changed.emit(current_language)


func translate(key: String) -> String:
    if not translations.has(key):
        return key

    var entry: Dictionary = translations[key]
    return str(entry.get(current_language, key))


func get_available_languages() -> Array[String]:
    return ["tg", "ru", "en"]
