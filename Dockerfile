# 第一阶段：从哪吒官方镜像里直接把程序“借”出来
FROM ghcr.io/nezhahq/agent:latest AS binary-source

# 第二阶段：构建你自己的运行环境
FROM alpine:latest

# 1. 安装基础运行库
RUN apk add --no-cache ca-certificates libc6-compat

# 2. 核心操作：直接从第一阶段拷贝现成的 nezha-agent 文件，完全不联网下载
COPY --from=binary-source /dashboard/nezha-agent /nezha-agent

# 3. 赋予执行权限
RUN chmod +x /nezha-agent

# 4. 启动指令（已填好你的参数）
CMD /nezha-agent -s zn.117.de5.net:80 -p ZCmpxMlhqwi25icfCDHGSYBl13kwBk2D --report-delay 3 --tls=false
