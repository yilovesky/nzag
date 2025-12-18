FROM alpine:latest

# 1. 安装基础工具
RUN apk add --no-cache curl ca-certificates bash

# 2. 设置哪吒参数（已填好）
ENV NZ_SERVER="zn.117.de5.net:80"
ENV NZ_CLIENT_SECRET="ZCmpxMlhqwi25icfCDHGSYBl13kwBk2D"

# 3. 核心修正：使用官方最稳的脚本，并强制不安装为服务
# 我们把下载和运行分开，确保构建能过
RUN curl -L https://raw.githubusercontent.com/nezhahq/scripts/main/agent/install.sh -o agent.sh && \
    chmod +x agent.sh && \
    bash agent.sh install_agent ${NZ_SERVER} ${NZ_CLIENT_SECRET} --tls=false --disable-service

# 4. 运行
CMD /opt/nezha/agent/nezha-agent -s ${NZ_SERVER} -p ${NZ_CLIENT_SECRET} --report-delay 3 --tls=false
