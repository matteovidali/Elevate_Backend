from ast import Call
from sre_constants import CALL
from flask import Flask
from flask import jsonify

CALL_LIST = []

def print_hello():
    return 'Hello World'

def call_floor(node_id, floor):
    if not node_id.isnumeric():
        return 'Node ID must be a number'
    if int(node_id) != 1:
        return 'Not reconized node id'
    if not floor.isnumeric():
        if floor.lower() == 'up':
            floor = 1
        elif floor.lower() == 'down':
            floor = 0
        else:
            return f'"{floor.lower()}" is not a recognized floor'
    
    CALL_LIST.append((node_id, floor))
    print(CALL_LIST)
    return f'Calling {floor} @ node {node_id}'

def check_list():
    return jsonify(CALL_LIST)

def get_next_call():
    if len(CALL_LIST) == 0:
        return '-1'
    call = f'{CALL_LIST[0][1]}'
    CALL_LIST.pop(0)
    return call

server = Flask(__name__)

server.add_url_rule('/', 'index', print_hello)
server.add_url_rule('/<node_id>/<floor>', 'floor_call', call_floor)
server.add_url_rule('/List', 'call_list', check_list)
server.add_url_rule('/getCall', 'get-next-call', get_next_call)

if __name__ == '__main__':
    server.debug = True
    server.run(host='0.0.0.0', port=80)