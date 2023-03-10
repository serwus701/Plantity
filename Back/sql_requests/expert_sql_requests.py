from tools import base64_to_blob


def sql_request_add_plant_to_encyclopedia(connection, user_input):
    sql_query = """INSERT INTO plants.encyclopedia (photo_id, species_name, species_description, how_often_to_water, 
    amount_of_sun, amount_of_water, difficulty) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"""

    connection.execute(sql_query, (user_input[0], user_input[1], user_input[2],
                                   int(user_input[3]), int(user_input[4]), int(user_input[5]), int(user_input[6]),
                                   int(user_input[7])))


def sql_request_edit_plant_description(connection, species_name, new_plant_description):
    sql_query = """UPDATE plants.encyclopedia SET species_description = %s WHERE species_name = %s"""
    connection.execute(sql_query, (new_plant_description, species_name))


def sql_request_edit_plant_photo(connection, species_name, photo):
    sql_query = """UPDATE plants.encyclopedia SET photo = %s WHERE species_name = %s"""
    connection.execute(sql_query, (base64_to_blob(photo), species_name))
