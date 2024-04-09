const mongoose = require("mongoose");
const UserAppointment = new mongoose.Schema({
  date: {
    require: true,
    type: String,
  },
  doctorId: {
    require: true,
    type: String,
  },
  userId: {
    require: true,
    type: String,
  },
  isComplete: {
    default: false,
    type: Boolean,
  },
});
const userAppointment = mongoose.model("userAppointment", UserAppointment);
module.exports = { userAppointment, UserAppointment };
