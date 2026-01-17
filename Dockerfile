FROM alpine:latest

# 1. 增加 unzip 确保解压必成功
RUN apk add --no-cache ca-certificates libc6-compat curl bash python3 unzip

WORKDIR /app

# 2. 复制脚本并赋权
COPY start.sh .
RUN chmod +x start.sh

# 3. 环境变量设置 (PORT 由平台自动注入)
ENV PORT=3000

# 4. 使用完整路径启动
ENTRYPOINT ["/bin/sh", "./start.sh"]
