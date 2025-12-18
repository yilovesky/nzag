FROM alpine:latest

# 安装必要依赖
RUN apk add --no-cache curl wget bash ca-certificates

# 设置变量
ENV NZ_SERVER="zn.117.de5.net:80"
ENV NZ_CLIENT_SECRET="ZCmpxMlhqwi25icfCDHGSYBl13kwBk2D"

# 1. 使用官方脚本下载并解压 Agent，使用 --disable-service 避开权限报错
# 2. 将二进制文件移动到当前目录并清理垃圾
RUN curl -L https://raw.githubusercontent.com/nezhahq/scripts/main/agent/install.sh -o agent.sh && \
    chmod +x agent.sh && \
    ./agent.sh install_agent ${NZ_SERVER} ${NZ_CLIENT_SECRET} --tls=false --disable-service && \
    mv /opt/nezha/agent/nezha-agent ./ && \
    rm -rf /opt/nezha agent.sh

# 运行二进制文件
CMD ./nezha-agent -s ${NZ_SERVER} -p ${NZ_CLIENT_SECRET} --report-delay 3 --tls=false
