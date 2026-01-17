# 使用包含 Node 和 Python 的镜像
FROM node:22-bullseye-slim

# 安装脚本运行所需的工具
RUN apt-get update && apt-get install -y curl unzip python3 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 拷贝所有文件
COPY . .

# 给予脚本执行权限
RUN chmod +x "开始脚本"

# 启动 (对应 package.json 里的 start)
CMD ["npm", "start"]
