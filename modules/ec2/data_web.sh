#!/bin/bash
yum update -y && yum upgrade -y

# Install httpd
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# Write a simple web page
cat <<EOF >> /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>
<body>
  <h1>Web IP (This page): $(hostname -I)</h1>
  <h1 id="app">App IP: </h1>
  <script>
    const appContent = document.getElementById("app");
    appContent.innerText += "$(hostname -I)";
  </script>
</body>
</html>
EOF
