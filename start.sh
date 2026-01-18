#!/bin/sh

# 1. 设置工作目录
WORKDIR=$(pwd)
echo "当前工作目录: $WORKDIR"

# 2. 启动 Node.js 背景进程 (负责端口响应和订阅)
# 删掉 Python 服务，由 index.js 统一管理 3000 端口
echo "正在启动 Node.js 服务..."
node index.js > node_server.log 2>&1 &

# 3. 等待 Node.js 占领端口
sleep 3

# 4. 下载哪吒客户端
echo "正在下载 nezha-agent..."
ARCH=$(uname -m)
[ "$ARCH" = "x86_64" ] && URL_ARCH="amd64" || URL_ARCH="arm64"

curl -L -f "https://github.com/nezhahq/agent/releases/latest/download/nezha-agent_linux_${URL_ARCH}.zip" -o agent.zip || { echo "下载失败"; exit 1; }
unzip -o agent.zip
chmod +x nezha-agent

# 5. 写入配置文件 (保持 NK 原始配置 [cite: 2026-01-13])
cat <<EOF > config.yml
client_secret: "p3joFK1jc3Z31YXqMXfNPvjjxx1lQknL"
debug: false
server: "nz.117.de5.net:443"
tls: true
EOF

# 6. 最终运行
echo "启动哪吒客户端..."
./nezha-agent run -c config.yml
