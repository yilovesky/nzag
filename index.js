const express = require("express");
const app = express(); // 1. 必须先定义 [cite: 2026-01-14]
const path = require("path");

const port = process.env.PORT || 3000;

// 2. 你的业务路由 (保持不动)
app.get("/", (req, res) => {
    res.send("System Active");
});

// 3. 节点自动命名逻辑 [cite: 2026-01-14]
app.get("/sub", (req, res) => {
    const nodeName = `NK-${Math.floor(Math.random() * 1000)}`;
    res.send(Buffer.from(`vless://uuid@host:443#${nodeName}`).toString('base64'));
});

// 4. 启动监听 (必须放在文件最后) [cite: 2026-01-14]
app.listen(port, '0.0.0.0', () => {
    console.log(`服务已启动，监听端口：${port}`);
});
