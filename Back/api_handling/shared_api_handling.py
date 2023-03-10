from flask import jsonify, request
import json

from functionalities.shared_functionalities import change_password, login, register

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


@app.route('/change/password', methods=['POST'])
def api_change_password():
    data = json.loads(request.data)
    user_login = data['username']
    new_password = data['new_password']
    old_password = data['old_password']

    answer = {'approval': change_password(user_login, new_password, old_password)}
    return jsonify(answer)
