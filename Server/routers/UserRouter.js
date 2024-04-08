const express = require("express");
const jwt = require("jsonwebtoken");
const { userModule, UserModule } = require("../Modules/UserModule");
const auth = require("../MiddleWare/UserMiddleWare");
const { doctorModule } = require("../DoctorModule/doctorModule");

const UserRouter = express.Router();
UserRouter.post("/user/signUp", async (req, res) => {
  try {
    const { name, emailAddress, age, homeAddress, phoneNumber } = req.body;

    let existingUser = await userModule.findOne({ phoneNumber });

    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User already exists with this PhoneNumber" });
    }

    const newUser = new userModule({
      name,
      emailAddress,
      age,
      homeAddress,
      phoneNumber,
    });

    const savedUser = await newUser.save();
    const token = jwt.sign({ id: savedUser._doc }, "passwordKey");

    res.json({ token, ...savedUser._doc });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
UserRouter.post("/tokenIsValid", async (req, res) => {
  try {
    const token = req.header("x-auth-token-w");
    if (!token) {
      return res.json(false);
    }
    const verified = jwt.verify(token, "passwordKey");
    if (!verified) {
      return res.json(false);
    }
    const user = await userModule.findById(verified.id);
    if (!user) {
      return res.json(false);
    }
    res.json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

UserRouter.get("/", auth, async (req, res) => {
  const user = await userModule.findById(req.user); //by using auth middleware
  res.json({ ...user._doc, token: req.token });
});
UserRouter.get("/allDoctors", auth, async (req, res) => {
  const allDoctors = await doctorModule.find({});
  if (allDoctors.length === 0) {
    return res.status(400).json({ msg: "No doctors found" });
  }
  res.json(allDoctors);
});
UserRouter.post("/SignUpUser", async (req, res) => {
  try {
    const { phoneNumber } = req.body;
    const user = await userModule.findOne({ phoneNumber });
    if (!user) {
      return res
        .status(400)
        .json({ msg: "No User Found with this PhoneNumber" });
    }
    const token = jwt.sign({ id: user._id }, "passwordKey");
    res.json({ token, ...user._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});
UserRouter.post("/User/SearchDoctor/:name", async (req, res) => {
  try {
    const doctors = await doctorModule.find({
      $or: [
        { name: { $regex: req.params.name, $options: "i" } },
        { specialist: { $regex: req.params.name, $options: "i" } },
      ],
    });

    if (doctors.length === 0) {
      const allDoctors = await doctorModule.find({});
      if (allDoctors.length === 0) {
        return res.status(400).json({ msg: "No doctors found" });
      }
      return res.json(allDoctors);
    }

    res.json(doctors);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
module.exports = UserRouter;
