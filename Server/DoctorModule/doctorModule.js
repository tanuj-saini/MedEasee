const mongoose = require("mongoose");
const {
  appointMentDetail,
  appointMentDetailsSchema,
} = require("./appointMentDetails");
const { userAppointment, UserAppointment } = require("./UserAppointed");
const { scheduleSchema } = require("./ScheduleTime");
const { chatDetailsSchema } = require("../Modules/chatDetails");
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
  selectedTimeSlot: {
    price: {
      type: String,
      require: true,
    },
    title: {
      type: String,
      require: true,
    },
    isVedio: {
      type: Boolean,
      require: true,
    },
    timeSlotPicks: scheduleSchema,
  },
  timeSlot: [
    {
      appointMentDetails: [appointMentDetailsSchema],
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
const doctorModule = mongoose.model("doctorModule", DoctorModule);
module.exports = { doctorModule, DoctorModule };
