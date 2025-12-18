FROM alpine:latest

# 1. 安装基础环境
RUN apk add --no-cache curl ca-certificates bash

# 2. 设置环境变量
ENV NZ_SERVER="zn.117.de5.net:80"
ENV NZ_CLIENT_SECRET="ZCmpxMlhqwi25icfCDHGSYBl13kwBk2D"

# 3. 核心步骤：直接拉取官方脚本并执行 install_agent 动作
# --disable-service 会强制脚本不写系统目录，只下载二进制文件
RUN curl -L https://raw.githubusercontent.com/nezhahq/scripts/main/agent/install.sh -o agent.sh && \
    chmod +x agent.sh && \
    bash agent.sh install_agent ${NZ_SERVER} ${NZ_CLIENT_SECRET} --tls=false --disable-service

# 4. 运行 (脚本默认会把文件放在 /opt/nezha/agent/)
CMD /opt/nezha/agent/nezha-agent -s ${NZ_SERVER} -p ${NZ_CLIENT_SECRET} --report-delay 3 --tls=false
