FROM alpine:latest

# 安装必要依赖
RUN apk add --no-cache curl wget bash ca-certificates

# 设置变量
ENV NZ_SERVER="zn.117.de5.net:80"
ENV NZ_CLIENT_SECRET="ZCmpxMlhqwi25icfCDHGSYBl13kwBk2D"

# 下载适合的二进制文件并直接启动
# 注意：我们这里手动指定运行参数，绕过脚本安装过程
CMD curl -L https://github.com/nezhahq/agent/releases/latest/download/nezha-agent_linux_amd64.tar.gz -o nezha.tar.gz && \
    tar -zxvf nezha.tar.gz && \
    chmod +x nezha-agent && \
    ./nezha-agent -s ${NZ_SERVER} -p ${NZ_CLIENT_SECRET} --report-delay 3 --tls=false
