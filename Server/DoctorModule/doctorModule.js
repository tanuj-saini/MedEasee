const mongoose = require("mongoose");
const {
  appointMentDetail,
  appointMentDetailsSchema,
} = require("./appointMentDetails");
const { userAppointment, UserAppointment } = require("./UserAppointed");
const DoctorModule = mongoose.Schema({
  name: {
    require: true,
    type: String,
  },
  bio: {
    require: true,
    type: String,
  },
  phoneNumber: {
    require: true,
    type: String,
  },
  specialist: {
    require: true,
    type: String,
  },
  currentWorkingHospital: {
    require: true,
    type: String,
  },
  profilePic: {
    require: true,
    type: String,
  },
  registerNumbers: {
    require: true,
    type: String,
  },
  experience: {
    require: true,
    type: String,
  },
  emailAddress: {
    require: true,
    type: String,
  },
  age: {
    require: true,
    type: String,
  },
  applicationLeft: [
    {
      userId: {
        require: true,
        type: String,
      },
      appointMentDetails: [UserAppointment],
    },
  ],
  timeSlot: [
    {
      appointMentDetails: [appointMentDetailsSchema],
    },
  ],
});
const doctorModule = mongoose.model("doctorModule", DoctorModule);
module.exports = { doctorModule, DoctorModule };
