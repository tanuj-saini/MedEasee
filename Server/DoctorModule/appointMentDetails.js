const mongoose = require("mongoose");
const { scheduleSchema, scheduleTIme } = require("./ScheduleTime");

const appointMentDetailsSchema = new mongoose.Schema({
  price: {
    type: Number,
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
  timeSlotPicks: [
    {
      timeSlot: [scheduleSchema],
    },
  ],
});

const appointMentDetail = mongoose.model(
  "appointMentDetail",
  appointMentDetailsSchema
);

module.exports = { appointMentDetail, appointMentDetailsSchema };
