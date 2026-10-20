
extends Node
class_name MoneyManager

signal money_changed(new_amount: int)
signal purchase_completed(item_id: String)
signal purchase_failed(item_id: String)

var money: int = 5000


func add_money(amount: int) -> void:
    if amount <= 0:
        return

    money += amount
    money_changed.emit(money)


func can_afford(price: int) -> bool:
    return price >= 0 and money >= price


func spend_money(amount: int) -> bool:
    if amount <= 0 or money < amount:
        return false

    money -= amount
    money_changed.emit(money)
    return true


func purchase(item_id: String, price: int) -> bool:
    if item_id.is_empty() or price < 0:
        purchase_failed.emit(item_id)
        return false

    if not spend_money(price):
        purchase_failed.emit(item_id)
        return false

    purchase_completed.emit(item_id)
    return true


func get_money() -> int:
    return money


func set_money(amount: int) -> void:
    money = maxi(0, amount)
    money_changed.emit(money)
