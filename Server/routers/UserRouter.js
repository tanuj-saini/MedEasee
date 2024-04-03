const express = require("express");
const { userModule } = require("../Modules/UserModule");

const UserRouter = express.Router();
UserRouter.post("/user/signUp", async (req, res) => {
  try {
    const { name, emailAddress, age, homeAddress, phoneNumber } = req.body;

    // Check if a user with the provided email address already exists
    let existingUser = await userModule.findOne({ phoneNumber });

    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User already exists with this PhoneNumber" });
    }

    // Create a new user object
    const newUser = new userModule({
      name,
      emailAddress,
      age,
      homeAddress,
      phoneNumber,
    });

    // Save the new user to the database
    const savedUser = await newUser.save();

    res.json(savedUser);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = UserRouter;
