from flask import jsonify, request
import json
from __main__ import app

from functionalities.user_functionalities import search_for_plant_in_encyclopedia


@app.route('/search/encyclopedia', methods=['POST'])
def api_search_encyclopedia():
    data = json.loads(request.data)
    search_text = data['search_text']

    print(type(search_for_plant_in_encyclopedia(search_text)))
    try:
        json_answer = json.dumps(search_for_plant_in_encyclopedia(search_text), indent = 20)
    except Exception as e:
        print(e)
    #print(json_answer)

    answer = {'approval': "json_answer"}
    return jsonify(answer)