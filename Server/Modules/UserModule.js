const mongoose = require("mongoose");
const { UserAppointment } = require("../DoctorModule/UserAppointed");
const { chatDetailsSchema } = require("./chatDetails");
const UserModule = mongoose.Schema({
  name: {
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
  homeAddress: {
    require: true,
    type: String,
  },
  phoneNumber: {
    require: true,
    type: String,
  },
  appointment: [
    {
      doctorId: {
        require: true,
        type: String,
      },
      apppointLeft: [UserAppointment],
    },
  ],
  medicalShopHistory: [
    {
      MedicalId: {
        require: true,
        type: String,
      },
    },
  ],
  emergencyCall: [
    {
      HosptialId: {
        require: true,
        type: String,
      },
    },
  ],
  chat: [
    {
      appointMentId: {
        required: true,
        type: String,
      },
      messageCountSee: {
        required: true,
        type: String,
      },
      chatDetails: [chatDetailsSchema],
    },
  ],
  appointMentHistory: [UserAppointment],
});
const userModule = mongoose.model("userModule", UserModule);
module.exports = { userModule, UserModule };
