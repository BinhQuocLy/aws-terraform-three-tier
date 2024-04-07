#!/bin/bash
yum update -y && yum upgrade -y

# Install node.js 20
yum install -y nodejs20
ln -s -f /usr/bin/node-20 /usr/bin/node
ln -s -f /usr/bin/npm-20 /usr/bin/npm

# ======================================
# Write a simple web
# (For the simplified solution for CORS problem in the browser, I made a Node.JS webserver api for the Web-tier instead, then call the App-tier api for the simulation).
# ======================================
mkdir ~/web
cd ~/web

npm init -y
npm install express axios

cat <<EOF >> index.js
const express = require('express');
const axios = require('axios');

const app = express();
const port = 80;

app.get('/', async (req, res) => {
  const app_res = await axios.get('http://app.test.com');
  res.json({ 
    web_private_ip: "$(hostname -I)".trim(), 
    app_private_ip: app_res.data.ip 
  });
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
});
EOF
node index.js
