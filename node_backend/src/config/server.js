const express = require("express");
const cors = require("cors");

const app = express();
const server = require("http").createServer(app);

app.use(cors());
app.use(express.json());

const userRouter = require("../route/user");
const messageRouter = require("../route/message");

app.use("/user", userRouter);
app.use("/message", messageRouter);

app.get("/", (req, res) => {
  res.send("Hello Chat");
});

const PORT = process.env.PORT || 4000;

app.listen(PORT, () => console.log(`Server started on port ${PORT}`));

module.exports = server;
