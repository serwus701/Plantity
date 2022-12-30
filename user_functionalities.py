import sys
from sqlalchemy import create_engine

from user_sql_requests import sql_request_search_for_plants, sql_request_add_plant_to_library, \
    sql_request_get_plants_from_library, sql_request_delete_from_library

url = 'mysql://user:123password@127.0.0.1/plants'
engine = create_engine(url)
connection = engine.connect()


def search_for_plant_in_encyclopedia():
    user_input = input("Insert plant name")

    output = sql_request_search_for_plants(connection, user_input)

    for i in range(output[1]):
        sys.stdout.write(str(i))
        sys.stdout.write(": ")
        for j in range(7):
            sys.stdout.write(str(output[0][j][i]))
            sys.stdout.write(" | ")
        sys.stdout.write("\n")

    return output


def add_plant_to_library():
    function_output = search_for_plant_in_encyclopedia()

    position_input = input("insert record position to add")

    if 0 <= int(position_input) < function_output[1]:
        plant_nickname = input("insert plant nickname")
        sql_request_add_plant_to_library(connection, function_output[0][1][int(position_input)], plant_nickname)


def show_library():
    result = sql_request_get_plants_from_library(connection)

    sys.stdout.write("\n")

    for i in range(result[1]):
        sys.stdout.write(str(i) + ": Plant nickname: " + str(result[0][i][0]) + "\n")
        sys.stdout.write("Species name: " + str(result[0][i][2]) + "\n\n")

    loop = True
    while loop:
        plant_nickname = input("insert plant nickname to show details (type exit to leave loop)")
        if plant_nickname == "exit":
            loop = False
            continue
        show_plant_in_library(plant_nickname)


def show_plant_in_library(plant_nickname):
    result = sql_request_get_plants_from_library(connection)

    for i in range(result[1]):
        if plant_nickname.lower() not in result[0][i][0]:
            continue
        sys.stdout.write("Plant nickname: " + str(result[0][i][0]) + "\n")
        sys.stdout.write("Species name: " + str(result[0][i][2]) + "\n")
        sys.stdout.write("Description: " + str(result[0][i][3]) + "\n")
        sys.stdout.write(
            "How often to water: " + str(result[0][i][4]) + ", Amount of sun: " + str(result[0][i][5]) + "\n")
        sys.stdout.write("Amount of water: " + str(result[0][i][6]) + ", Difficulty: " + str(result[0][i][7]) + "\n\n")


def delete_from_library():
    result = sql_request_get_plants_from_library(connection)

    for i in range(result[1]):
        sys.stdout.write(str(i) + ": Plant nickname: " + str(result[0][i][0]) + "\n")
        sys.stdout.write("Species name: " + str(result[0][i][2]) + "\n\n")

    plant_numer_to_delete = input("Insert plant position to delete:")
    try:
        plant_nickname = result[0][int(plant_numer_to_delete)][0]
        sql_request_delete_from_library(connection, plant_nickname)
    except:
        print("invalid number")
