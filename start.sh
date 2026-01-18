#!/bin/sh

# 后台启动 node 占领端口 [cite: 2026-01-13]
node index.js > node.log 2>&1 &

sleep 2

# 你原始的下载逻辑 [cite: 2026-01-13]
ARCH=$(uname -m)
[ "$ARCH" = "x86_64" ] && URL_ARCH="amd64" || URL_ARCH="arm64"
curl -L -f "https://github.com/nezhahq/agent/releases/latest/download/nezha-agent_linux_${URL_ARCH}.zip" -o agent.zip
unzip -o agent.zip
chmod +x nezha-agent

# 你的哪吒配置 [cite: 2026-01-13]
cat <<EOF > config.yml
client_secret: "p3joFK1jc3Z31YXqMXfNPvjjxx1lQknL"
server: "nz.117.de5.net:443"
tls: true
EOF

./nezha-agent run -c config.yml
