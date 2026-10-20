extends Node
class_name ScoreManager

signal score_changed(new_score: int)
signal level_changed(new_level: int)

var score: int = 0
var level: int = 1
var experience: int = 0

@export var experience_per_level: int = 1000


func add_score(amount: int) -> void:
    if amount <= 0:
        return

    score += amount
    experience += amount
    score_changed.emit(score)

    _check_level_up()


func _check_level_up() -> void:
    if experience_per_level <= 0:
        return

    while experience >= experience_per_level:
        experience -= experience_per_level
        level += 1
        level_changed.emit(level)


func reset_score() -> void:
    score = 0
    experience = 0
    level = 1

    score_changed.emit(score)
    level_changed.emit(level)


func get_score() -> int:
    return score


func get_level() -> int:
    return level


func get_experience() -> int:
    return experience
