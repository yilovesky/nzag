FROM alpine:latest

# 1. 安装基础依赖
RUN apk add --no-cache curl wget bash ca-certificates libc6-compat

# 2. 设置变量
ENV NZ_SERVER="zn.117.de5.net:80"
ENV NZ_CLIENT_SECRET="ZCmpxMlhqwi25icfCDHGSYBl13kwBk2D"

# 3. 运行逻辑：
# A. 下载脚本
# B. 用脚本的 install_agent 功能下载程序（不安装服务）
# C. 直接启动 /opt/nezha/agent/nezha-agent
CMD curl -L https://raw.githubusercontent.com/nezhahq/scripts/main/agent/install.sh -o agent.sh && \
    chmod +x agent.sh && \
    bash agent.sh install_agent ${NZ_SERVER} ${NZ_CLIENT_SECRET} --tls=false --disable-service && \
    /opt/nezha/agent/nezha-agent -s ${NZ_SERVER} -p ${NZ_CLIENT_SECRET} --report-delay 3 --tls=false
