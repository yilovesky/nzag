FROM alpine:latest

# 安装必要依赖
RUN apk add --no-cache curl wget bash ca-certificates

# 设置变量
ENV NZ_SERVER="zn.117.de5.net:80"
ENV NZ_CLIENT_SECRET="ZCmpxMlhqwi25icfCDHGSYBl13kwBk2D"

# 直接下载二进制文件并运行，跳过安装服务步骤
CMD curl -L https://github.com/nezhahq/agent/releases/latest/download/nezha-agent_linux_amd64.tar.gz -o nezha.tar.gz && \
    tar -zxvf nezha.tar.gz && \
    chmod +x nezha-agent && \
    ./nezha-agent -s ${NZ_SERVER} -p ${NZ_CLIENT_SECRET} --report-delay 3 --tls=false
