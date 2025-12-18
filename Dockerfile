FROM alpine:latest

# 1. 安装基础依赖
RUN apk add --no-cache curl wget bash ca-certificates libc6-compat

# 2. 设置变量
ENV NZ_SERVER="zn.117.de5.net:80"
ENV NZ_CLIENT_SECRET="ZCmpxMlhqwi25icfCDHGSYBl13kwBk2D"

# 3. 这里的逻辑：
# A. 直接用 curl 下载压缩包（绕过脚本，不给它报错的机会）
# B. 解压并赋予权限
# C. 直接启动 nezha-agent 进程
CMD curl -L https://github.com/nezhahq/agent/releases/latest/download/nezha-agent_linux_amd64.tar.gz -o nezha.tar.gz && \
    tar -zxvf nezha.tar.gz && \
    chmod +x nezha-agent && \
    ./nezha-agent -s ${NZ_SERVER} -p ${NZ_CLIENT_SECRET} --report-delay 3 --tls=false
