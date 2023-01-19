from flask import jsonify, request
import json
from __main__ import app

from functionalities.user_functionalities import search_for_plant_in_encyclopedia, add_plant_to_library, show_library, \
    delete_from_library


@app.route('/get/encyclopedia', methods=['POST'])
def api_search_encyclopedia():
    data = json.loads(request.data)

    search_text = data['search_text']

    json_answer = json.dumps(search_for_plant_in_encyclopedia(search_text))

    return json_answer


@app.route('/add/library', methods=['POST'])
def api_add_plant_to_library():
    data = json.loads(request.data)

    species_name = data['species_name']
    plant_nickname = data['plant_nickname']
    user_logged = data['user_logged']

    answer = {'confirmation': add_plant_to_library(plant_nickname, species_name, user_logged)}
    return jsonify(answer)


@app.route('/get/library', methods=['POST'])
def api_show_library():
    data = json.loads(request.data)

    user_logged = data['user_logged']

    json_answer = json.dumps(show_library(user_logged))
    return json_answer


@app.route('/delete/library', methods=['POST'])
def api_delete_from_library():
    data = json.loads(request.data)

    plant_nickname = data['plant_nickname']
    user_logged = data['user_logged']

    answer = {'confirmation': delete_from_library(plant_nickname, user_logged)}
    return jsonify(answer)
