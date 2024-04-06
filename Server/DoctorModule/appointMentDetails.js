const mongoose = require("mongoose");
const { scheduleSchema, scheduleTIme } = require("./ScheduleTime");

const appointMentDetailsSchema = new mongoose.Schema({
  price: {
    type: Number,
    require: true,
  },
  timeSlotPicks: [
    {
      timeSlot: [scheduleSchema],
    },
  ],
  //timeSlotPicks: [scheduleSchema],
});

const appointMentDetail = mongoose.model(
  "appointMentDetail",
  appointMentDetailsSchema
);

module.exports = { appointMentDetail, appointMentDetailsSchema };
