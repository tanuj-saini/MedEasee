const express = require("express");
const jwt = require("jsonwebtoken");

const authDoctor = require("../MiddleWare/doctorMiddleware");
const { doctorModule } = require("../DoctorModule/doctorModule");
const { appointMentDetail } = require("../DoctorModule/appointMentDetails");
const { scheduleTIme } = require("../DoctorModule/ScheduleTime");
const { userModule } = require("../Modules/UserModule");
const { userAppointment } = require("../DoctorModule/UserAppointed");
const doctorRouter = express.Router();
doctorRouter.post("/doctor/signUp", async (req, res) => {
  try {
    const {
      name,
      bio,
      phoneNumber,
      specialist,
      currentWorkingHospital,
      profilePic,
      registerNumbers,
      experience,
      emailAddress,
      age,
    } = req.body;
    let existingUser = await doctorModule.findOne({ phoneNumber });

    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User already exists with this PhoneNumber" });
    }
    const newDoctor = new doctorModule({
      name,
      bio,
      phoneNumber,
      specialist,
      currentWorkingHospital,
      profilePic,
      registerNumbers,
      experience,
      emailAddress,
      age,
    });
    const savedDoctor = await newDoctor.save();
    const token = jwt.sign({ id: savedDoctor._doc }, "passwordKeyD");

    res.json({ token, ...savedDoctor._doc });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

doctorRouter.post("/tokenIsValid/doctor", async (req, res) => {
  try {
    const token = req.header("x-auth-token-D");
    if (!token) {
      return res.json(false);
    }
    const verified = jwt.verify(token, "passwordKeyD");
    if (!verified) {
      return res.json(false);
    }
    const doctor = await doctorModule.findById(verified.id);
    if (!doctor) {
      return res.json(false);
    }
    res.json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

doctorRouter.get("/D", authDoctor, async (req, res) => {
  const doctor = await doctorModule.findById(req.userDoctor);
  res.json({ ...doctor._doc, token: req.token });
});

doctorRouter.post("/AppointmentModify", authDoctor, async (req, res) => {
  try {
    const { date, timeSlots, price, title, isVedio } = req.body;

    if (!price) {
      return res.status(400).send({ message: "Price is required" });
    }

    const newTimeSlot = new scheduleTIme({
      date,
      timeSlots,
    });
    await newTimeSlot.save();

    const newAppointMentDetail = new appointMentDetail({
      price,
      title,
      isVedio,
      timeSlotPicks: [
        {
          timeSlot: newTimeSlot,
        },
      ],
    });

    await newAppointMentDetail.save();

    const doctor = await doctorModule.findById(req.userDoctor);
    if (!doctor) {
      return res.status(400).send({ message: "Doctor not found" });
    }

    doctor.timeSlot.push({ appointMentDetails: [newAppointMentDetail] });
    await doctor.save();

    res.status(200).send(doctor);
  } catch (error) {
    console.error(error);
    res
      .status(500)
      .send({ message: "An error occurred while modifying the appointment" });
  }
});

// doctorRouter.post("/AppointmentModifyUpdate", authDoctor, async (req, res) => {
//   try {
//     const { date, timeSlots, price, title } = req.body;
//     let timeSlotId = req.query.timeSlotId;
//     let appointmentDetailsId = req.query.appointmentDetailsId;
//     if (
//       !date ||
//       !timeSlots ||
//       !price ||
//       !title ||
//       !timeSlotId ||
//       !appointmentDetailsId
//     ) {
//       return res.status(400).send({
//         message:
//           "Date, timeSlots, price, title, timeSlotId, and appointmentDetailsId are required",
//       });
//     }

//     const doctor = await doctorModule.findById(req.user);
//     if (!doctor) {
//       return res.status(400).send({ message: "Doctor not found" });
//     }

//     const appointmentDetail = await appointMentDetail.findById(
//       appointmentDetailsId
//     );
//     const timeSlot = await scheduleTIme.findById(timeSlotId);

//     if (!appointmentDetail || !timeSlot) {
//       return res
//         .status(400)
//         .send({ message: "Appointment detail or time slot not found" });
//     }

//     appointmentDetail.date = date;
//     appointmentDetail.timeSlots = timeSlots;
//     appointmentDetail.price = price;
//     appointmentDetail.title = title;

//     timeSlot.date = date;
//     timeSlot.timeSlots = timeSlots;

//     await appointmentDetail.save();
//     await timeSlot.save();

//     res.status(200).send(doctor);
//   } catch (error) {
//     console.error(error);
//     res
//       .status(500)
//       .send({ message: "An error occurred while modifying the appointment" });
//   }
// });

doctorRouter.post("/SignUpDoctor", async (req, res) => {
  try {
    const { phoneNumber } = req.body;
    const doctor = await doctorModule.findOne({ phoneNumber });
    if (!doctor) {
      return res
        .status(400)
        .json({ msg: "No doctor Found with this PhoneNumber" });
    }
    const token = jwt.sign({ id: doctor._id }, "passwordKeyD");
    res.json({ token, ...doctor._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

doctorRouter.get("/getDoctorData", authDoctor, async (req, res) => {
  try {
    const doctorId = req.query.doctorId;

    if (!doctorId) {
      return res.status(400).json({ error: "Doctor ID is required" });
    }

    const doctor = await doctorModule.findById(doctorId);
    if (!doctor) {
      return res.status(400).json({ error: "Doctor not found" });
    }

    res.json(doctor);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

doctorRouter.post("/selectedTimeSlot", authDoctor, async (req, res) => {
  try {
    const { date, timeSlots, price, title, isVedio } = req.body;
    const doctorId = req.query.doctorId;
    if (!doctorId) {
      return res.status(400).json({ error: "Doctor ID is required" });
    }
    // /AppointmentModify

    const doctor = await doctorModule.findById(doctorId);
    if (!doctor) {
      return res.status(400).json({ error: "Doctor not found" });
    }

    if (!price) {
      return res.status(400).send({ message: "Price is required" });
    }

    const newTimeSlot = new scheduleTIme({
      date,
      timeSlots,
    });

    await newTimeSlot.save();

    doctor.selectedTimeSlot = {
      price,
      title,
      isVedio,
      timeSlotPicks: newTimeSlot,
    };

    await doctor.save();

    res.json(doctor);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

doctorRouter.delete("/delete/AppointMents", async (req, res) => {
  const { doctorId, userId, appointMentId } = req.body;

  try {
    const doctor = await doctorModule.findById(doctorId);

    if (!doctor) {
      return res.status(400).json({ message: "Doctor not found" });
    }

    const appointmentIndex = doctor.applicationLeft.findIndex(
      (appointment) =>
        appointment.userId === userId &&
        appointment.appointMentDetails.some(
          (detail) => detail._id.toString() === appointMentId
        )
    );

    if (appointmentIndex === -1) {
      return res
        .status(400)
        .json({ message: "User appointment not found for this doctor" });
    }

    doctor.appointMentHistory.push(
      ...doctor.applicationLeft[appointmentIndex].appointMentDetails
    );

    doctor.applicationLeft.splice(appointmentIndex, 1);

    await doctor.save();

    return res.json({
      message: "Appointment deleted successfully",
      doctor: doctor,
    });
  } catch (error) {
    console.error("Error deleting user appointment:", error);
    return res.status(500).json({ message: "Internal Server Error" });
  }
});

doctorRouter.delete("/delete/AppointMents/user", async (req, res) => {
  try {
    const { doctorId, userId, appointMentId } = req.body;
    const user = await userModule.findById(userId);

    if (!user) {
      return res.status(400).json({ message: "User not found" });
    }

    const userAppointmentIndex = user.appointment.findIndex(
      (appointment) =>
        appointment.doctorId === doctorId &&
        appointment.apppointLeft.some(
          (detail) => detail._id.toString() === appointMentId
        )
    );

    if (userAppointmentIndex === -1) {
      return res
        .status(400)
        .json({ message: "Appointment not found for this user" });
    }

    user.appointMentHistory.push(
      ...user.appointment[userAppointmentIndex].apppointLeft
    );

    user.appointment.splice(userAppointmentIndex, 1);

    await user.save();
    return res.json({
      message: "Appointment deleted successfully",
      user: user,
    });
  } catch (error) {
    console.error("Error deleting user appointment:", error);
    return res.status(500).json({ message: "Internal Server Error" });
  }
});

doctorRouter.post("/updateIsComplete/appointMent", async (req, res) => {
  try {
    const { doctorId, userId, appointMentId } = req.body;

    const doctor = await doctorModule.findOne({ _id: doctorId });
    const user = await userModule.findOne({ _id: userId });

    if (!doctor) {
      return res.status(400).json({ message: "Doctor not found" });
    }

    const appointmentIndexDoctor = doctor.applicationLeft.findIndex(
      (appointment) =>
        appointment.userId === userId &&
        appointment.appointMentDetails.some(
          (details) => details._id.toString() === appointMentId
        )
    );

    if (appointmentIndexDoctor === -1) {
      return res
        .status(400)
        .json({ message: "Doctor's appointment not found" });
    }

    doctor.applicationLeft[appointmentIndexDoctor].appointMentDetails.forEach(
      (details) => {
        if (details._id.toString() === appointMentId) {
          details.isComplete = true;
        }
      }
    );

    await doctor.save();

    const appointmentIndexUser = user.appointment.findIndex(
      (appointment) =>
        appointment.doctorId === doctorId &&
        appointment.apppointLeft.some(
          (details) => details._id.toString() === appointMentId
        )
    );

    if (appointmentIndexUser === -1) {
      return res.status(400).json({ message: "User's appointment not found" });
    }

    user.appointment[appointmentIndexUser].apppointLeft.forEach((details) => {
      if (details._id.toString() === appointMentId) {
        details.isComplete = true;
      }
    });

    await user.save();

    return res.json(doctor);
  } catch (e) {
    console.error(e);
    return res.status(500).json({ message: "Internal Server Error" });
  }
});

doctorRouter.post("/updateRatingAndComments/appointMent", async (req, res) => {
  try {
    const { doctorId, userId, appointMentId, comments, rating } = req.body;

    // Find the DoctorModule
    const doctor = await doctorModule.findOne({ _id: doctorId });
    const user = await userModule.findOne({ _id: userId });

    if (!doctor) {
      return res.status(400).json({ message: "Doctor not found" });
    }

    const appointmentIndexDoctor = doctor.applicationLeft.findIndex(
      (appointment) =>
        appointment.userId === userId &&
        appointment.appointMentDetails.some(
          (details) => details._id.toString() === appointMentId
        )
    );

    if (appointmentIndexDoctor === -1) {
      return res
        .status(400)
        .json({ message: "Doctor's appointment not found" });
    }

    doctor.applicationLeft[appointmentIndexDoctor].appointMentDetails.forEach(
      (details) => {
        if (details._id.toString() === appointMentId) {
          details.rating = rating;
          details.comments = comments;
        }
      }
    );

    await doctor.save();

    const appointmentIndexUser = user.appointment.findIndex(
      (appointment) =>
        appointment.doctorId === doctorId &&
        appointment.apppointLeft.some(
          (details) => details._id.toString() === appointMentId
        )
    );

    if (appointmentIndexUser === -1) {
      return res.status(400).json({ message: "User's appointment not found" });
    }

    user.appointment[appointmentIndexUser].apppointLeft.forEach((details) => {
      if (details._id.toString() === appointMentId) {
        details.rating = rating;
        details.comments = comments;
      }
    });

    await user.save();

    return res.json(user);
  } catch (e) {
    console.error(e);
    return res.status(500).json({ message: "Internal Server Error" });
  }
});

module.exports = doctorRouter;
