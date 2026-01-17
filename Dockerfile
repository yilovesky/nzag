FROM docker.io/meteor/galaxy-node:22.9.0

WORKDIR /app

# 拷贝依赖描述文件
COPY package*.json ./

# 安装依赖
RUN npm install

# 拷贝项目所有文件
COPY . .

# --- 删掉了 RUN npm run build 这行，因为你的项目不需要编译 ---

# 启动程序
CMD ["npm", "start"]
