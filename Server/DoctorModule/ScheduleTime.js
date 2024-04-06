const mongoose = require("mongoose");

const timeSlotSchema = new mongoose.Schema({
  hour: {
    type: Number,
    required: true,
    min: 0,
    max: 23,
  },
  minute: {
    type: Number,
    required: true,
    enum: [0, 15, 30, 45],
  },
});

const scheduleSchema = new mongoose.Schema({
  date: {
    type: Date,
    required: true,
  },
  timeSlots: [timeSlotSchema],
});

const scheduleTIme = mongoose.model("scheduleTIme", scheduleSchema);

module.exports = { scheduleTIme, scheduleSchema };
