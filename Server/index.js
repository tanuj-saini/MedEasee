const express = require("express");
const mongoose = require("mongoose");
const UserRouter = require("./routers/UserRouter");
const doctorRouter = require("./routers/DoctorRouter");
const mongooseUrl =
  "mongodb+srv://medeaszzz:Av19YTj6Pdy6swkJ@cluster0.qzc4sbo.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

const PORT = 3001;

const app = express();
app.use(express.json());

app.use(UserRouter);
app.use(doctorRouter);

mongoose
  .connect(mongooseUrl)
  .then(() => {
    console.log("Connection Successful in mongoose");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Connect at ${PORT}`);
});
