from flask import Flask
from flask import jsonify

CALL_LIST = []

def print_hello():
    return 'Hello World'

def call_floor(node_id, floor):
    CALL_LIST.append((node_id, floor))
    print(CALL_LIST)
    return f'Calling floor {floor} @ node {node_id}'

def check_list():
    return jsonify(CALL_LIST)

server = Flask(__name__)

server.add_url_rule('/', 'index', print_hello)
server.add_url_rule('/<node_id>/<floor>', 'floor_call', call_floor)
server.add_url_rule('/List', 'call_list', check_list)

if __name__ == '__main__':
    server.debug = True
    server.run(host='0.0.0.0', port=80)