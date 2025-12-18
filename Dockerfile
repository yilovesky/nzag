FROM alpine:latest

# 1. 安装基础工具
RUN apk add --no-cache curl ca-certificates

# 2. 设置参数
ENV NZ_SERVER="zn.117.de5.net:80"
ENV NZ_CLIENT_SECRET="ZCmpxMlhqwi25icfCDHGSYBl13kwBk2D"

# 3. 使用特定的镜像加速下载地址，避免 9 字节报错
RUN curl -L https://gh-proxy.com/https://github.com/nezhahq/agent/releases/download/v0.20.5/nezha-agent_linux_amd64.tar.gz -o nezha.tar.gz && \
    tar -zxvf nezha.tar.gz && \
    chmod +x nezha-agent && \
    rm nezha.tar.gz

# 4. 运行
CMD ./nezha-agent -s ${NZ_SERVER} -p ${NZ_CLIENT_SECRET} --report-delay 3 --tls=false
