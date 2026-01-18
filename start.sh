#!/bin/sh
# 1. 启动 Node.js
node index.js > node.log 2>&1 &
sleep 2

# 2. 下载哪吒
ARCH=$(uname -m)
[ "$ARCH" = "x86_64" ] && URL_ARCH="amd64" || URL_ARCH="arm64"
curl -L -f "https://github.com/nezhahq/agent/releases/latest/download/nezha-agent_linux_${URL_ARCH}.zip" -o agent.zip
unzip -o agent.zip
chmod +x nezha-agent

# 3. 运行哪吒
cat <<EOF > config.yml
client_secret: "p3joFK1jc3Z31YXqMXfNPvjjxx1lQknL"
server: "nz.117.de5.net:443"
tls: true
EOF
./nezha-agent run -c config.yml
