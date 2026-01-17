#!/bin/bash

# ================== 1. 核心参数 ==================
AGENT_SECRET="p3joFK1jc3Z31YXqMXfNPvjjxx1lQknL"
AGENT_SERVER="nz.117.de5.net:443"
PORT=${SERVER_PORT:-${PORT:-10027}}

# ================== 2. 检查并下载 (你的原始稳健逻辑) ==================
if [ ! -f "nezha-agent" ]; then
    echo "正在下载 nezha-agent..."
    # 自动识别架构
    ARCH=$(uname -m)
    [ "$ARCH" = "x86_64" ] && URL_ARCH="amd64" || URL_ARCH="arm64"
    
    curl -L "https://github.com/nezhahq/agent/releases/latest/download/nezha-agent_linux_${URL_ARCH}.zip" -o agent.zip
    
    # --- 核心改动：多重解压方案，适配所有系统 ---
    if command -v unzip >/dev/null 2>&1; then
        echo "使用 unzip 解压..."
        unzip -o agent.zip
    elif command -v jar >/dev/null 2>&1; then
        echo "unzip 不存在，尝试使用 jar xvf 解压..."
        jar xvf agent.zip
    else
        echo "错误：系统既没有 unzip 也没有 jar，请联系管理员安装。"
        exit 1
    fi
    
    chmod +x nezha-agent
    rm -f agent.zip
fi

# ================== 3. 写入配置文件 (V1 结构) ==================
echo "正在写入配置文件..."
cat <<EOF > config.yml
client_secret: ${AGENT_SECRET}
debug: false
server: ${AGENT_SERVER}
tls: true
EOF

# ================== 4. 复杂伪装网页 ==================
# 生成一个高端的单页伪装监控界面
cat <<EOF > index.html
<!DOCTYPE html>
<html>
<head><title>Cloud Node Status</title><meta charset="utf-8">
<style>
    body { background: #000; color: #0f0; font-family: 'Courier New', monospace; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
    .status-container { border: 1px solid #0f0; padding: 30px; box-shadow: 0 0 15px #0f0; }
    .blink { animation: blink 1.2s infinite; }
    @keyframes blink { 50% { opacity: 0; } }
</style>
</head>
<body>
    <div class="status-container">
        <h2>> SYSTEM_NODE: ACTIVE</h2>
        <p>> ENCRYPTION: TLS_v1.3</p>
        <p>> MONITORING: ENABLED</p>
        <p>> STATUS: RUNNING<span class="blink">_</span></p>
    </div>
</body>
</html>
EOF

# 启动后台伪装 Web 服务 (不阻塞，不使用 nohup 以提高兼容性)
(python3 -m http.server $PORT > /dev/null 2>&1 &)

# ================== 5. 启动程序 ==================
echo -e "\033[32m哪吒客户端Runing...\033[0m"
# 直接运行，不加任何官方脚本前缀，确保面板直接捕获
./nezha-agent run -c config.yml
