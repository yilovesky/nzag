FROM alpine:latest

# 1. 安装基础工具
RUN apk add --no-cache curl ca-certificates

# 2. 这是你最开始用的那个官方链接，但我换了一个更稳的 CDN 加速前缀
# 这样可以绕过 GitHub 对 Koyeb IP 的限制
RUN curl -L https://ghproxy.net/https://github.com/nezhahq/agent/releases/latest/download/nezha-agent_linux_amd64.tar.gz -o nezha.tar.gz && \
    tar -zxvf nezha.tar.gz && \
    chmod +x nezha-agent && \
    rm nezha.tar.gz

# 3. 运行
# 参数已根据你的信息填好
CMD ./nezha-agent -s zn.117.de5.net:80 -p ZCmpxMlhqwi25icfCDHGSYBl13kwBk2D --report-delay 3 --tls=false
