FROM alpine:latest

# 安装必要依赖
RUN apk add --no-cache curl wget bash ca-certificates

# 设置变量
ENV NZ_SERVER="zn.117.de5.net:80"
ENV NZ_CLIENT_SECRET="ZCmpxMlhqwi25icfCDHGSYBl13kwBk2D"

# 在构建阶段就下载好并解压，避免启动时报错
RUN wget https://github.com/nezhahq/agent/releases/latest/download/nezha-agent_linux_amd64.tar.gz && \
    tar -zxvf nezha-agent_linux_amd64.tar.gz && \
    chmod +x nezha-agent && \
    rm -f nezha-agent_linux_amd64.tar.gz

# 直接运行二进制文件
CMD ./nezha-agent -s ${NZ_SERVER} -p ${NZ_CLIENT_SECRET} --report-delay 3 --tls=false
