// const express = require("express");
// const mongoose = require("mongoose");
// const UserRouter = require("./routers/UserRouter");
// const doctorRouter = require("./routers/DoctorRouter");
// const mongooseUrl =
//   "mongodb+srv://medeaszzz:Av19YTj6Pdy6swkJ@cluster0.qzc4sbo.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

// const PORT = 3001;

// const app = express();
// app.use(express.json());

// app.use(UserRouter);
// app.use(doctorRouter);

// mongoose
//   .connect(mongooseUrl)
//   .then(() => {
//     console.log("Connection Successful in mongoose");
//   })
//   .catch((e) => {
//     console.log(e);
//   });

// app.listen(PORT, "0.0.0.0", () => {
//   console.log(`Connect at ${PORT}`);
// });
const express = require("express");
const mongoose = require("mongoose");
const http = require("http");
const socketIO = require("socket.io");
const cors = require("cors");
const axios = require("axios");

const UserRouter = require("./routers/UserRouter");
const doctorRouter = require("./routers/DoctorRouter");
const chatRouter = require("./routers/ChatRouter");

const mongooseUrl =
  "mongodb+srv://medeaszzz:Av19YTj6Pdy6swkJ@cluster0.qzc4sbo.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

const PORT = process.env.PORT || 3001;

const app = express();
const server = http.createServer(app);
const io = socketIO(server);

app.use(express.json());
app.use(cors());

// Connect to MongoDB
mongoose
  .connect(mongooseUrl)
  .then(() => {
    console.log("Connection Successful in mongoose");
  })
  .catch((e) => {
    console.log(e);
  });

// User and Doctor Routers
app.use(UserRouter);
app.use(doctorRouter);
app.use(chatRouter);
// Socket.io connection
const clients = {};
io.on("connection", (socket) => {
  console.log("connected");
  console.log(socket.id, "has joined");

  socket.on("Id", (Id) => {
    clients[Id] = socket;
    console.log(Id);
  });

  socket.on("messageEvent", async (msg) => {
    // console.log("Received message:", msg);

    const reciverId = msg.reciverId;
    console.log("Target ID", reciverId);

    if (clients[reciverId]) {
      clients[reciverId].emit("messageEvent", msg);
      console.log("Sending message to target client...");
      try {
        const isDoctor = msg.isDoctor; // Assuming isDoctor is present in msg
        const { currentId, reciverId, message, time, appointMentId } = msg;

        // Prepare data for API call
        const requestData = {
          params: { doctorId: isDoctor }, // Assuming you need to pass isDoctor as a query parameter
          currentId,
          appointMentId,
          reciverId,
          message,
          time,
        };

        const response = await axios.post(
          "http://localhost:3001/api/message",
          requestData
        ); // Assuming the API endpoint is accessible internally
        console.log("API Response:", response.data);
      } catch (error) {
        console.error("Error calling API:", error);
      }
    } else {
      console.log("Target client not found.");
    }
  });
});

// Start the server
server.listen(PORT, "0.0.0.0", () => {
  console.log(`Server started on port ${PORT}`);
});
