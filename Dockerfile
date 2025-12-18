FROM alpine:latest

# 安装必要依赖
RUN apk add --no-cache curl wget bash ca-certificates

# 设置变量
ENV NZ_SERVER="zn.117.de5.net:80"
ENV NZ_CLIENT_SECRET="ZCmpxMlhqwi25icfCDHGSYBl13kwBk2D"

# 直接下载 v1.14.1 版本的二进制文件（手动指定版本最稳）
# 绕过 install.sh，直接在当前目录解压
RUN wget https://github.com/nezhahq/agent/releases/download/v1.14.1/nezha-agent_linux_amd64.tar.gz && \
    tar -zxvf nezha-agent_linux_amd64.tar.gz && \
    chmod +x nezha-agent && \
    rm -f nezha-agent_linux_amd64.tar.gz

# 运行二进制文件
CMD ./nezha-agent -s ${NZ_SERVER} -p ${NZ_CLIENT_SECRET} --report-delay 3 --tls=false
