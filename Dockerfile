# 1. 直接拉取哪吒官方已经打包好的镜像作为“零件库”
FROM ghcr.io/nezhahq/agent:latest AS binary-source

# 2. 使用 alpine 作为你的运行环境
FROM alpine:latest

# 3. 安装基础运行库
RUN apk add --no-cache ca-certificates libc6-compat

# 4. 核心步骤：直接从官方镜像里把 nezha-agent 拷贝出来！
# 这一步是 Docker 内部完成的，不经过任何 curl 下载链接
COPY --from=binary-source /dashboard/nezha-agent /nezha-agent

# 5. 赋予执行权限
RUN chmod +x /nezha-agent

# 6. 设置启动参数
ENV NZ_SERVER="zn.117.de5.net:80"
ENV NZ_CLIENT_SECRET="ZCmpxMlhqwi25icfCDHGSYBl13kwBk2D"

# 7. 启动指令
CMD /nezha-agent -s ${NZ_SERVER} -p ${NZ_CLIENT_SECRET} --report-delay 3 --tls=false
