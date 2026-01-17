#!/bin/sh

# ================== 1. 核心参数 ==================
AGENT_SECRET="p3joFK1jc3Z31YXqMXfNPvjjxx1lQknL"
AGENT_SERVER="nz.117.de5.net:443"
# 必须读取 PORT 变量
REAL_PORT=${PORT:-3000}

# ================== 2. 伪装网页 (必须先启动) ==================
mkdir -p ./web
echo "<h1>System Active</h1><p>Node running on port ${REAL_PORT}</p>" > ./web/index.html
# 监听 0.0.0.0 是关键，确保外网/平台能访问
python3 -m http.server --bind 0.0.0.0 ${REAL_PORT} --directory ./web > /dev/null 2>&1 &

# ================== 3. 下载并运行监控 ==================
ARCH=$(uname -m)
[ "$ARCH" = "x86_64" ] && URL_ARCH="amd64" || URL_ARCH="arm64"

curl -L "https://github.com/nezhahq/agent/releases/latest/download/nezha-agent_linux_${URL_ARCH}.zip" -o agent.zip
unzip -o agent.zip
chmod +x nezha-agent

# 写入配置
cat <<EOF > config.yml
client_secret: ${AGENT_SECRET}
debug: false
server: ${AGENT_SERVER}
tls: true
EOF

# 前台运行监控程序 (不要加 &)，防止容器退出
./nezha-agent run -c config.yml
