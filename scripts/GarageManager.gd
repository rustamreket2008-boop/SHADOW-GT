
extends Node
class_name GarageManager

signal selected_car_changed(car_id: String)
signal car_unlocked(car_id: String)

var cars: Array[Dictionary] = [
    {
        "id": "shadow_gt",
        "name": "SHADOW GT",
        "price": 0,
        "speed": 220.0,
        "unlocked": true
    },
    {
        "id": "sport_red",
        "name": "SPORT RED",
        "price": 5000,
        "speed": 240.0,
        "unlocked": false
    },
    {
        "id": "supercar",
        "name": "SUPERCAR",
        "price": 15000,
        "speed": 300.0,
        "unlocked": false
    },
    {
        "id": "black_gt",
        "name": "BLACK GT",
        "price": 25000,
        "speed": 280.0,
        "unlocked": false
    }
]

var selected_car_id: String = "shadow_gt"


func get_cars() -> Array[Dictionary]:
    return cars.duplicate(true)


func get_selected_car() -> Dictionary:
    for car: Dictionary in cars:
        if car["id"] == selected_car_id:
            return car.duplicate(true)

    return {}


func select_car(car_id: String) -> bool:
    for car: Dictionary in cars:
        if car["id"] == car_id and car["unlocked"]:
            selected_car_id = car_id
            selected_car_changed.emit(car_id)
            return true

    return false


func unlock_car(car_id: String, money: int) -> int:
    for car: Dictionary in cars:
        if car["id"] == car_id:
            if car["unlocked"]:
                return money

            var price: int = int(car["price"])

            if money < price:
                return money

            money -= price
            car["unlocked"] = true
            car_unlocked.emit(car_id)

            return money

    return money


func is_car_unlocked(car_id: String) -> bool:
    for car: Dictionary in cars:
        if car["id"] == car_id:
            return bool(car["unlocked"])

    return false
