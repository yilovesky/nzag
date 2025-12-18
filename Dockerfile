FROM alpine:latest

# 1. 安装基础工具
RUN apk add --no-cache curl ca-certificates

# 2. 设置哪吒参数
ENV NZ_SERVER="zn.117.de5.net:80"
ENV NZ_CLIENT_SECRET="ZCmpxMlhqwi25icfCDHGSYBl13kwBk2D"

# 3. 使用新仓库 (nezhahq/agent) 的最新稳定版链接
# 这里的链接是目前最新且真实有效的
RUN curl -L https://github.com/nezhahq/agent/releases/download/v0.20.5/nezha-agent_linux_amd64.tar.gz -o nezha.tar.gz && \
    tar -zxvf nezha.tar.gz && \
    chmod +x nezha-agent && \
    rm nezha.tar.gz

# 4. 运行二进制文件
CMD ./nezha-agent -s ${NZ_SERVER} -p ${NZ_CLIENT_SECRET} --report-delay 3 --tls=false
