const express = require("express");
var http = require("http");
const cors = require("cors");
const app = express();
const port = process.env.PORT || 5000;
var server = http.createServer(app);
var io = require("socket.io")(server);
app.use(cors());
app.use(express.json());
var clients = {};
io.on("connection", (socket) => {
  console.log("connected");
  console.log(socket.id, "has joined");
  socket.on("Id", (Id) => {
    clients[Id] = socket;
    console.log(Id);
  });
  socket.on("messageEvent", (msg) => {
    console.log("Received message:", msg);
    let targetId = msg.targetId;
    console.log("Target ID", targetId);
    // console.log("Client:", clients[targetId]);
    if (clients[targetId]) {
      clients[targetId].emit("messageEvent", msg);
      console.log("Sending message to target client...");
    } else {
      console.log("Target client not found.");
    }
  });
});

server.listen(port, "0.0.0.0", () => {
  console.log("server started");
});
console.log("jfsjk");
