const express = require("express");
const jwt = require("jsonwebtoken");

const authDoctor = require("../MiddleWare/doctorMiddleware");
const { doctorModule } = require("../DoctorModule/doctorModule");
const { appointMentDetail } = require("../DoctorModule/appointMentDetails");
const { scheduleTIme } = require("../DoctorModule/ScheduleTime");
const { userModule } = require("../Modules/UserModule");
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
  const doctor = await doctorModule.findById(req.user);
  res.json({ ...doctor._doc, token: req.token });
});

doctorRouter.post("/AppointmentModify", authDoctor, async (req, res) => {
  try {
    const { date, timeSlots, price, title } = req.body;

    // Check if price is provided in the request body
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
      timeSlotPicks: [
        {
          timeSlot: newTimeSlot,
        },
      ],
    });

    await newAppointMentDetail.save();

    const doctor = await doctorModule.findById(req.user);
    if (!doctor) {
      return res.status(404).send({ message: "Doctor not found" });
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
//       return res.status(404).send({ message: "Doctor not found" });
//     }

//     const appointmentDetail = await appointMentDetail.findById(
//       appointmentDetailsId
//     );
//     const timeSlot = await scheduleTIme.findById(timeSlotId);

//     if (!appointmentDetail || !timeSlot) {
//       return res
//         .status(404)
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
      return res.status(404).json({ error: "Doctor not found" });
    }

    res.json(doctor);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

doctorRouter.post("/selectedTimeSlot", authDoctor, async (req, res) => {
  try {
    const { date, timeSlots, price, title } = req.body;
    const doctorId = req.query.doctorId;
    if (!doctorId) {
      return res.status(400).json({ error: "Doctor ID is required" });
    }

    const doctor = await doctorModule.findById(doctorId);
    if (!doctor) {
      return res.status(404).json({ error: "Doctor not found" });
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
      timeSlotPicks: newTimeSlot, // Assign the new time slot
    };

    await doctor.save();

    res.status(201).json(doctor);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

doctorRouter.delete("/delete/AppointMents", async (req, res) => {
  const { doctorId, userId } = req.body;

  try {
    // Find the DoctorModule document by its ID
    const doctor = await doctorModule.findById(doctorId);

    if (!doctor) {
      return res.status(404).json({ message: "Doctor not found" });
    }

    // Find the index of the UserAppointment to remove from the doctor's records
    const appointmentIndex = doctor.applicationLeft.findIndex(
      (appointment) => appointment.userId === userId
    );

    if (appointmentIndex === -1) {
      return res
        .status(404)
        .json({ message: "User appointment not found for this doctor" });
    }

    // Remove the UserAppointment from the doctor's records
    doctor.applicationLeft.splice(appointmentIndex, 1);

    // Save the updated DoctorModule document
    await doctor.save();

    // Find the UserModule document by its ID
    const user = await userModule.findById(userId);

    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    // Find the index of the appointment to remove from the user's records
    const userAppointmentIndex = user.appointment.findIndex(
      (appointment) => appointment.doctorId === doctorId
    );

    if (userAppointmentIndex === -1) {
      return res
        .status(404)
        .json({ message: "Appointment not found for this user" });
    }

    // Remove the appointment from the user's records
    user.appointment.splice(userAppointmentIndex, 1);

    // Save the updated UserModule document
    await user.save();

    return res.json(user);
  } catch (error) {
    console.error("Error deleting user appointment:", error);
    return res.status(500).json({ message: "Internal Server Error" });
  }
});

module.exports = doctorRouter;
