from ast import Call
from sre_constants import CALL
from flask import Flask
from flask import jsonify

CALL_LIST = []

# brief:    Translate an incoming string into a floor
# param  s: String value of floor 
# retval:   Integer floor value
def get_floor(s):
    floors = {'up' : 1,
              'down' : 0}
    s = s.lower()
    if not s.isnumeric():
        return floors[s] if s in floors else -1
    
    return int(s)

# brief:          Checks if a gien node exists in a node_list
# param  node_id: a string to check in the node id list
# retval:         bool - True if exists 
def check_node(node_id):
    node_ids = ['luddy_1']

    if node_id not in node_ids:
        return False
    
    return True

    
# brief:    Function to run @ root node
# param:    None
# retval:   String to display @ root node
def handle_root():
    return 'Root'

# breif:         Validates request and adds a call to the call list
# param node_id: a string value with the node ID
# param floor:   a string value with the desired floor (gets validated)
# retval:        Confirmation message or issue message
def call_floor(node_id, floor):
    if not check_node(node_id):
        return 'Invalid Node ID'

    temp = get_floor(floor)
    if temp < 0:
        return f'"{floor.lower()}" is not a recognized floor'
    
    CALL_LIST.append((node_id, floor))
    return f'Calling {floor} @ node {node_id}'

# brief:    Gives a list of the current waiting rides
# param:    None
# retval:   json - list of calls
def check_list():
    return jsonify(CALL_LIST)

# brief:    returns next waiting call
# param:    None
# retval:   call
def get_next_call():
    if len(CALL_LIST) == 0:
        return '-1'
    call = f'{CALL_LIST[0][1]}'
    CALL_LIST.pop(0)
    return call

server = Flask(__name__)

server.add_url_rule('/', 'index', handle_root)
server.add_url_rule('/<node_id>/<floor>', 'floor_call', call_floor)
server.add_url_rule('/List', 'call_list', check_list)
server.add_url_rule('/getCall', 'get-next-call', get_next_call)

if __name__ == '__main__':
    server.debug = True
    server.run(host='0.0.0.0', port=80)