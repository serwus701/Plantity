from flask import jsonify, request
import json
from functionalities.startup_functionalities import login, register

from __main__ import app


@app.route('/login', methods=['POST'])
def api_login():
    data = json.loads(request.data)
    user_login = data['username']
    password = data['password']

    answer = {'approval': login(user_login, password)}
    return jsonify(answer)


@app.route('/register', methods=['POST'])
def api_register():
    data = json.loads(request.data)
    user_login = data['username']
    password = data['password']
    firstname = data['firstname']
    lastname = data['lastname']

    answer = {'approval': register(firstname, lastname, user_login, password)}
    return jsonify(answer)
