
extends Node
class_name GarageEconomyManager

signal money_changed(amount: int)
signal car_selected(car_id: String)
signal purchase_result(success: bool, message: String)

var money: int = 5000
var owned_cars: Array[String] = ["starter"]
var selected_car: String = "starter"

var car_prices: Dictionary = {
    "starter": 0,
    "sport_red": 2500,
    "sport_blue": 3000,
    "supercar": 12000,
    "racing": 8000,
    "black_gt": 15000,
    "street": 4500,
    "police": 10000,
    "green_racer": 6500,
    "neon": 20000
}


func buy_car(car_id: String) -> bool:
    if not car_prices.has(car_id):
        purchase_result.emit(false, "Мошин ёфт нашуд")
        return false

    if owned_cars.has(car_id):
        purchase_result.emit(false, "Ин мошин аллакай харида шудааст")
        return false

    var price: int = int(car_prices[car_id])

    if money < price:
        purchase_result.emit(false, "Пули кофӣ нест")
        return false

    money -= price
    owned_cars.append(car_id)
    money_changed.emit(money)
    purchase_result.emit(true, "Мошин харида шуд")
    return true


func select_car(car_id: String) -> bool:
    if not owned_cars.has(car_id):
        return false

    selected_car = car_id
    car_selected.emit(car_id)
    return true


func add_money(amount: int) -> void:
    if amount <= 0:
        return

    money += amount
    money_changed.emit(money)


func get_car_price(car_id: String) -> int:
    return int(car_prices.get(car_id, -1))


func is_car_owned(car_id: String) -> bool:
    return owned_cars.has(car_id)
