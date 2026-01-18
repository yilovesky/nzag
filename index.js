const express = require("express");
const app = express();
const path = require("path");

// 基础变量
const port = process.env.PORT || 3000;
const SUB_PATH = process.env.SUB_PATH || 'sub';

// --- 节点自动重命名逻辑 (2026-01-14 需求) ---
app.get(`/${SUB_PATH}`, (req, res) => {
    // 示例：生成带随机编号的节点名
    const nodeName = `NK-Node-${Math.floor(Math.random() * 899) + 100}`;
    const vlessLink = `vless://uuid@yourdomain.com:443?encryption=none#${nodeName}`;
    res.send(Buffer.from(vlessLink).toString('base64'));
});

// 根路由响应（解决容器健康检查，防止 503）
app.get("/", (req, res) => {
    res.status(200).send("System Active");
});

// --- 启动监听 ---
// 修复 ReferenceError: app 未定义 [cite: 2026-01-14]
app.listen(port, '0.0.0.0', () => {
    console.log(`Node.js 服务已启动，监听端口：${port}`);
});
