#!/bin/sh

# ================== 1. 核心参数 ==================
AGENT_SECRET="p3joFK1jc3Z31YXqMXfNPvjjxx1lQknL"
AGENT_SERVER="nz.117.de5.net:443"
PORT=${SERVER_PORT:-${PORT:-3000}}

# 定义工作缓存目录
WORK_DIR="/tmp"
cd $WORK_DIR

# ================== 2. 检查并下载 ==================
echo "正在下载 nezha-agent..."
ARCH=$(uname -m)
[ "$ARCH" = "x86_64" ] && URL_ARCH="amd64" || URL_ARCH="arm64"

# 下载到 /tmp 目录
curl -L "https://github.com/nezhahq/agent/releases/latest/download/nezha-agent_linux_${URL_ARCH}.zip" -o agent.zip

if [ -f "agent.zip" ]; then
    unzip -o agent.zip
    chmod +x nezha-agent
    rm -f agent.zip
else
    echo "下载失败！"
    exit 1
fi

# ================== 3. 写入配置文件 ==================
echo "正在写入配置文件..."
cat <<EOF > config.yml
client_secret: ${AGENT_SECRET}
debug: false
server: ${AGENT_SERVER}
tls: true
EOF

# ================== 4. 复杂伪装网页 ==================
cat <<EOF > index.html
<!DOCTYPE html>
<html>
<head><title>Cloud Node Status</title><meta charset="utf-8">
<style>
    body { background: #000; color: #0f0; font-family: 'Courier New', monospace; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
    .status-container { border: 1px solid #0f0; padding: 30px; box-shadow: 0 0 15px #0f0; }
</style>
</head>
<body>
    <div class="status-container">
        <h2>> SYSTEM_NODE: ACTIVE</h2>
        <p>> STATUS: RUNNING</p>
    </div>
</body>
</html>
EOF

# 启动伪装网页 (指向 /tmp 目录)
python3 -m http.server $PORT > /dev/null 2>&1 &

# ================== 5. 启动程序 ==================
echo -e "\033[32m哪吒客户端 Running...\033[0m"
./nezha-agent run -c config.yml
