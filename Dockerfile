FROM alpine:latest

# 安装必要组件
RUN apk add --no-cache ca-certificates libc6-compat curl bash python3 unzip

# 依然设置工作目录，但我们脚本里会 cd 到 /tmp
WORKDIR /app

# 复制脚本
COPY start.sh .
RUN chmod +x start.sh

# 声明端口
ENV PORT=3000

# 启动
CMD ["/bin/sh", "./start.sh"]
