extends Node

var apples = 0

func collect_apple():
    apples += 1

func get_apples():
    return apples

func reset_level():
    apples = 0