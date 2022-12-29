import pandas as pd

import shared_functionalities
from tools import get_dataframe_size, get_library_id


def sql_request_search_for_plants(connection, search_text):
    column_names = ["photo_id", "species_name", "species_description", "how_often_to_water", "amount_of_sun",
                    "amount_of_water", "difficulty"]
    result_array = [[], [], [], [], [], [], []]

    sql_query = """SELECT * FROM plants.encyclopedia"""

    df = pd.read_sql_query(sql_query, connection)

    size = get_dataframe_size(df)
    final_size = size

    for i in range(size):
        if search_text.lower() in df.iloc[i]["species_name"].lower():
            for j in range(7):
                result_array[j].insert(0, df.iloc[i][column_names[j]])
        else:
            final_size -= 1

    return result_array, final_size


def sql_request_add_plant_to_library(connection, plant_name, plant_nickname):
    sql_query = """SELECT species_id FROM plants.encyclopedia WHERE species_name = %s"""
    df = pd.read_sql_query(sql_query, connection, params=[plant_name])
    species_id = df.iloc[0]["species_id"]

    library_id = get_library_id()

    sql_query = """INSERT INTO plants.plants (plant_name, species_id, library_id) VALUES (%s, %s, %s)"""
    connection.execute(sql_query, (plant_nickname, species_id, library_id))


def sql_request_get_plants_from_library(connection):
    column_names = ["photo_id", "species_name", "species_description", "how_often_to_water",
                    "amount_of_sun",
                    "amount_of_water", "difficulty"]
    result_array = [[], [], [], [], [], [], [], []]

    library_id = get_library_id()

    sql_query = """SELECT * FROM plants.plants WHERE library_id = %s"""
    library_items_df = pd.read_sql_query(sql_query, connection, params=[library_id])

    size = get_dataframe_size(library_items_df)

    for i in range(size):
        sql_query = """SELECT * FROM plants.encyclopedia WHERE species_id = %s"""
        df = pd.read_sql_query(sql_query, connection, params=[library_items_df.iloc[i]["species_id"]])
        species_name = df.iloc[0]["species_name"]

        sql_query = """SELECT * FROM plants.encyclopedia WHERE species_name = %s"""
        species_df = pd.read_sql_query(sql_query, connection, params=[species_name])

        temp_result = []
        temp_result.insert(0, library_items_df.iloc[i]["plant_name"])
        for j in range(7):
            temp_result.insert(0, species_df.iloc[0][column_names[j]])

        temp_result.reverse()

        result_array.insert(0, temp_result)

    return result_array, size
