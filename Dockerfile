FROM alpine:latest

# 安装基础依赖
RUN apk add --no-cache curl wget bash ca-certificates

# 这里的参数已经根据你提供的信息填好
ENV NZ_SERVER="zn.117.de5.net:80"
ENV NZ_CLIENT_SECRET="ZCmpxMlhqwi25icfCDHGSYBl13kwBk2D"

# 执行安装脚本并保持进程不退出
CMD curl -L https://raw.githubusercontent.com/nezhahq/scripts/main/agent/install.sh -o agent.sh && \
    chmod +x agent.sh && \
    env NZ_SERVER=${NZ_SERVER} NZ_TLS=false NZ_CLIENT_SECRET=${NZ_CLIENT_SECRET} ./agent.sh && \
    tail -f /dev/null
