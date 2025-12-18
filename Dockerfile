FROM alpine:latest

# 1. 安装基础工具
RUN apk add --no-cache curl ca-certificates

# 2. 直接在构建时下载好二进制文件，并放在根目录
# 我们换一个更稳定的旧版链接，这个链接通常不会被 GitHub 拦截
RUN curl -L https://github.com/nezhahq/agent/releases/download/v0.16.5/nezha-agent_linux_amd64.tar.gz -o nezha.tar.gz && \
    tar -zxvf nezha.tar.gz && \
    chmod +x nezha-agent && \
    rm nezha.tar.gz

# 3. 设置启动指令
# 这里的参数根据你提供的信息已经填好
CMD ./nezha-agent -s zn.117.de5.net:80 -p ZCmpxMlhqwi25icfCDHGSYBl13kwBk2D --report-delay 3 --tls=false
