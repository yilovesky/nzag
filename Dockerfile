FROM alpine:latest

# 安装必要的系统依赖
RUN apk add --no-cache curl wget bash ca-certificates

# 设置哪吒参数（已根据你提供的信息填好）
ENV NZ_SERVER="zn.117.de5.net:80"
ENV NZ_CLIENT_SECRET="ZCmpxMlhqwi25icfCDHGSYBl13kwBk2D"

# 下载并启动 Agent
# 注意：因为你的服务器端口是 80，通常不需要开启 TLS
CMD curl -L https://raw.githubusercontent.com/nezhahq/scripts/main/agent/install.sh -o agent.sh && \
    chmod +x agent.sh && \
    env NZ_SERVER=${NZ_SERVER} NZ_TLS=false NZ_CLIENT_SECRET=${NZ_CLIENT_SECRET} ./agent.sh && \
    tail -f /dev/null
