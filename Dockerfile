FROM alpine:latest

# 1. 安装基础环境 (bash 是运行脚本必须的)
RUN apk add --no-cache curl ca-certificates bash libc6-compat

# 2. 设置哪吒参数 (已根据你的信息填好)
ENV NZ_SERVER="zn.117.de5.net:80"
ENV NZ_CLIENT_SECRET="ZCmpxMlhqwi25icfCDHGSYBl13kwBk2D"

# 3. 核心修正：使用“备用加速地址”下载脚本，并强制只下载不安装
RUN curl -L https://mirror.ghproxy.com/https://raw.githubusercontent.com/nezhahq/scripts/main/agent/install.sh -o agent.sh && \
    chmod +x agent.sh && \
    bash agent.sh install_agent ${NZ_SERVER} ${NZ_CLIENT_SECRET} --tls=false --disable-service || true

# 4. 确保文件在正确的位置并给予权限
RUN if [ -f /opt/nezha/agent/nezha-agent ]; then cp /opt/nezha/agent/nezha-agent /nezha-agent; fi && \
    chmod +x /nezha-agent

# 5. 启动指令
CMD /nezha-agent -s zn.117.de5.net:80 -p ZCmpxMlhqwi25icfCDHGSYBl13kwBk2D --report-delay 3 --tls=false
