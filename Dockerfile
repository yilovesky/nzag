# 1. 直接使用 alpine，这是 Docker Hub 镜像，Fly.io 拉取最稳定
FROM alpine:latest

# 2. 安装基础运行库和 curl (用于下载二进制文件)
RUN apk add --no-cache ca-certificates libc6-compat curl bash

# 3. 设置工作目录
WORKDIR /app

# 4. 直接在构建时下载二进制文件，避开 GitHub 镜像仓库
# 这里下载的是官方 linux-amd64 版本
RUN curl -L https://github.com/nezhahq/agent/releases/latest/download/nezha-agent_linux_amd64.zip -o agent.zip && \
    unzip -o agent.zip && \
    chmod +x nezha-agent && \
    rm agent.zip

# 5. 设置环境变量 (你的面板地址和密钥)
ENV NZ_SERVER="nz.117.de5.net:443"
ENV NZ_CLIENT_SECRET="p3joFK1jc3Z31YXqMXfNPvjjxx1lQknL"

# 6. 启动指令
# 修复了你的参数：tls 建议根据面板实际情况开启/关闭
# 注意：你的地址是 nz.117.de5.net (你刚才打成了 zn)
CMD ./nezha-agent run -s ${NZ_SERVER} -p ${NZ_CLIENT_SECRET} --report-delay 3 --tls
