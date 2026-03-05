from flask import Flask, jsonify, request, render_template

app = Flask(__name__)
DYNAMIC_STRING = "Hello, World! (Default)"

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/api/string', methods=['GET'])
def get_string():
    global DYNAMIC_STRING
    return jsonify({"string": DYNAMIC_STRING})

@app.route('/api/string', methods=['POST'])
def set_string():
    global DYNAMIC_STRING
    data = request.get_json()
    if not data or 'string' not in data:
        return jsonify({"error": "Missing 'string' in JSON payload"}), 400
    DYNAMIC_STRING = data['string']
    return jsonify({"message": "String updated successfully", "string": DYNAMIC_STRING})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
