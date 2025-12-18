FROM alpine:latest

# 1. 安装基础工具
RUN apk add --no-cache ca-certificates libc6-compat curl

# 2. 设置变量
ENV NZ_SERVER="zn.117.de5.net:80"
ENV NZ_CLIENT_SECRET="ZCmpxMlhqwi25icfCDHGSYBl13kwBk2D"

# 3. 绕过所有下载！直接利用哪吒官方提供的极简安装方式（走 Docker 内部镜像流）
# 如果 ghcr.io 被封，我们换成 Docker Hub 的镜像源，这个通常不会被封
RUN curl -L https://hub.docker.com/v2/repositories/nezhahq/agent/tags/latest > /dev/null || true

# 4. 这里的逻辑改为：直接下载单文件版，并使用另一个镜像加速站
RUN curl -L https://ghp.ci/https://github.com/nezhahq/agent/releases/download/v0.20.5/nezha-agent_linux_amd64.tar.gz -o nezha.tar.gz && \
    tar -zxvf nezha.tar.gz && \
    chmod +x nezha-agent && \
    rm nezha.tar.gz

# 5. 启动
CMD ./nezha-agent -s ${NZ_SERVER} -p ${NZ_CLIENT_SECRET} --report-delay 3 --tls=false
