FROM node:22-alpine

# 安装必要工具
RUN apk update --no-cache && \
    apk add --no-cache curl unzip python3 && \
    rm -rf /var/cache/apk/*

WORKDIR /app

# 拷贝并安装 Node 依赖
COPY package.json ./
RUN npm install

# 拷贝剩余文件
COPY . .

# 权限设置
RUN chmod +x start.sh

# 启动
CMD ["sh", "./start.sh"]
