from flask import jsonify, request
import json
from __main__ import app

from functionalities.expert_functionalities import add_plant_to_encyclopedia, edit_plant_description


@app.route('/add/encyclopedia', methods=['POST'])
def api_add_encyclopedia():
    data = json.loads(request.data)

    user_input = []

    user_input.insert(0, data['photo_id'])
    user_input.insert(1, data['species_name'])
    user_input.insert(2, data['species_description'])
    user_input.insert(3, data['how_often_to_water'])
    user_input.insert(4, data['amount_of_sun'])
    user_input.insert(5, data['amount_of_water'])
    user_input.insert(6, data['difficulty'])

    answer = {'confirmation': add_plant_to_encyclopedia(user_input)}

    return jsonify(answer)


@app.route('/edit/encyclopedia', methods=['POST'])
def api_edit_encyclopedia():
    data = json.loads(request.data)

    position = data['position']
    description = data['plant_description']
    search_input = data['search_input']

    json_answer = json.dumps(edit_plant_description(position, description, search_input))

    return jsonify(json_answer)
