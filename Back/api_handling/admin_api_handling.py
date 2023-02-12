from flask import jsonify, request
import json
from __main__ import app

from functionalities.admin_functionalities import get_users, edit_if_expert, delete_client, delete_record


@app.route('/get/user', methods=['POST'])
def api_get_users():
    data = json.loads(request.data)

    search_text = data['search_text']

    json_answer = json.dumps(get_users())

    return json_answer


@app.route('/edit/user', methods=['POST'])
def api_edit_if_expert():
    data = json.loads(request.data)

    user_login = data['user_login']

    answer = {'confirmation': edit_if_expert(user_login)}

    return jsonify(answer)


@app.route('/delete/user', methods=['POST'])
def api_delete_client():
    data = json.loads(request.data)

    user_login = data['user_login']

    answer = {'confirmation': delete_client(user_login)}

    return jsonify(answer)


@app.route('/delete/', methods=['POST'])
def api_delete_record():
    data = json.loads(request.data)

    species_name = data['species_name']

    answer = {'confirmation': delete_record(species_name)}

    return jsonify(answer)
