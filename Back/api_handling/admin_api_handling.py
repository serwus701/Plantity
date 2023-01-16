from flask import jsonify, request
import json
from __main__ import app

from functionalities.admin_functionalities import get_users, edit_if_expert, delete_client, delete_record


@app.route('/get/user', methods=['POST'])
def api_get_users():
    data = json.loads(request.data)

    search_text = data['search_text']

    json_answer = json.dumps(get_users(search_text))

    return json_answer


@app.route('/edit/user', methods=['POST'])
def api_edit_if_expert():
    data = json.loads(request.data)

    name_to_search = data['name_to_search']
    chosen_position = data['chosen_position']

    answer = {'confirmation': edit_if_expert(name_to_search, chosen_position)}

    return jsonify(answer)


@app.route('/delete/user', methods=['POST'])
def api_delete_client():
    data = json.loads(request.data)

    name_to_search = data['name_to_search']
    chosen_position = data['chosen_position']

    delete_client(name_to_search, chosen_position)
    answer = {'confirmation': delete_client(name_to_search, chosen_position)}

    return jsonify(answer)


@app.route('/delete/encyclopedia', methods=['POST'])
def api_delete_record():
    data = json.loads(request.data)

    position_input = data['position_input']
    search_text = data['search_text']

    answer = {'confirmation': delete_record(position_input, search_text)}

    return jsonify(answer)
