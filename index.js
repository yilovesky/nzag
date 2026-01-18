const express = require("express");
const app = express(); 
const port = process.env.PORT || 3000;

app.get("/", (req, res) => {
    res.send("System Active");
});

app.listen(port, '0.0.0.0', () => {
    console.log(`服务已启动，监听端口：${port}`);
});
