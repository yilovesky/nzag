# 使用轻量的 Alpine 镜像
FROM alpine:latest

# 安装脚本运行所需的依赖：bash, curl, python3 (用于伪装网页), libc6-compat (哪吒运行必需)
RUN apk add --no-cache ca-certificates libc6-compat curl bash python3

WORKDIR /app

# 将你的脚本复制进镜像
COPY start.sh .

# 给脚本执行权限
RUN chmod +x start.sh

# 设置默认端口变量（Flootup 通常会自动分配 PORT 变量）
ENV PORT=3000

# 启动脚本
CMD ["./start.sh"]
