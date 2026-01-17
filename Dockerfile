FROM docker.io/meteor/galaxy-node:22.9.0

# 设置工作目录
WORKDIR /app

# 先拷贝 package.json
COPY package*.json ./

# 安装依赖
RUN npm install

# 拷贝项目剩余文件
COPY . .

# --- 注意：这里已经删掉了 RUN npm run build ---

# 启动程序
CMD ["npm", "start"]
