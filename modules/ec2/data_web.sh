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
  <h2>Web IP (This page): $(hostname -I)</h2>
  <h2 id="app">App IP: </h2>
  <script>
    const appContent = document.getElementById("app");
    fetch("http://internal-tf-test-alb-app-1439849174.ap-southeast-1.elb.amazonaws.com", {
      redirect: 'follow',
      mode: "cors",
      headers: {
        "Content-Type": "application/json"
      }
    })
      .then(res => res.json())
      .then(data => {
        appContent.innerText += data.ip;
      });
  </script>
</body>
</html>
EOF
