#!/bin/sh

# ================== 1. 核心参数 ==================
AGENT_SECRET="p3joFK1jc3Z31YXqMXfNPvjjxx1lQknL"
AGENT_SERVER="nz.117.de5.net:443"

# 关键修改：Galaxy Cloud 必须监听 $PORT 环境变量
# 如果 $PORT 为空，默认使用 3000
REAL_PORT=${PORT:-3000}

# 使用当前工作目录，避免 /tmp 权限问题
WORK_DIR=$(pwd)
cd $WORK_DIR

# ================== 2. 检查并下载 ==================
echo "正在检测架构并下载 nezha-agent..."
ARCH=$(uname -m)
case "$ARCH" in
    x86_64) URL_ARCH="amd64" ;;
    aarch64|arm64) URL_ARCH="arm64" ;;
    *) URL_ARCH="amd64" ;;
esac

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
cat <<EOF > config.yml
client_secret: ${AGENT_SECRET}
debug: false
server: ${AGENT_SERVER}
tls: true
EOF

# ================== 4. 复杂伪装网页 ==================
# 创建一个专门的网页目录
mkdir -p ./web
cat <<EOF > ./web/index.html
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
        <p>> PORT: ${REAL_PORT}</p>
    </div>
</body>
</html>
EOF

# 启动伪装网页 (在后台运行)
# 注意：一定要监听 0.0.0.0
echo "启动伪装网页在端口: ${REAL_PORT}"
python3 -m http.server --directory ./web ${REAL_PORT} > /dev/null 2>&1 &

# ================== 5. 启动监控程序 (前台运行) ==================
echo -e "\033[32m哪吒客户端启动中...\033[0m"
# 去掉 &，让 nezha-agent 在前台运行，防止容器退出
./nezha-agent run -c config.yml
