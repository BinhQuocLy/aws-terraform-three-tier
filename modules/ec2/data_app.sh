#!/bin/bash
yum update -y && yum upgrade -y

# Install pip, flask
yum install -y pip
pip install flask flask-cors

# ======================================
# Write a simple flask app
# ======================================
cd ~
cat <<EOF >> main.py
from flask import Flask, jsonify
import socket

app = Flask(__name__)

@app.route('/')
def index():
  hostname = socket.gethostname()
  ip = socket.gethostbyname(hostname)
  response = jsonify({ "ip": ip })
  return response

app.run(host='0.0.0.0', port=80)
EOF
python3 ./main.py
