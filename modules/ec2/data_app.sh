#!/bin/bash
yum update -y && yum upgrade -y

# Install pip, flask
yum install -y pip
pip install flask

# Write a simple flask app
cd ~
cat <<EOF >> main.py
from flask import Flask
import socket

app = Flask(__name__)

@app.route('/')
def index():
  hostname = socket.gethostname()
  ip = socket.gethostbyname(hostname)
  return ip

app.run(host='0.0.0.0', port=80)
EOF
python3 ./main.py
