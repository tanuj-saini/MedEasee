const express = require("express");
const { ChatDetail } = require("../Modules/chatDetails");
const bodyParser = require("body-parser");
const auth = require("../MiddleWare/UserMiddleWare");
const authDoctor = require("../MiddleWare/doctorMiddleware");
const { doctorModule } = require("../DoctorModule/doctorModule");
const { userModule } = require("../Modules/UserModule");
const chatRouter = express();
chatRouter.use(bodyParser.json());

chatRouter.post("/api/message", async (req, res) => {
  try {
    const isDoctor = req.body.params.doctorId;
    console.log(isDoctor);
    const {
      currentId,
      reciverId,
      message,
      time,
      appointMentId,
      isSeen,
      messageCountSee,
    } = req.body;
    console.log(appointMentId);

    let chatModule = new ChatDetail({
      reciverId,
      message,
      isSeen,
      time,
      itsMe: true,
    });
    let RchatModule = new ChatDetail({
      reciverId: currentId,
      message,
      isSeen,
      time,
      itsMe: false,
    });

    chatModule = await chatModule.save();
    RchatModule = await RchatModule.save();
    let Cuser, Ruser;
    if (isDoctor) {
      Cuser = await doctorModule.findById(currentId);
      Ruser = await userModule.findById(reciverId);
    } else {
      Cuser = await userModule.findById(currentId);
      Ruser = await doctorModule.findById(reciverId);
    }
    console.log(Cuser);
    console.log(Ruser);

    let Cchat = Cuser.chat.find((chat) => chat.appointMentId === appointMentId);

    if (Cchat) {
      Cchat.chatDetails.push(chatModule);
    } else {
      Cuser.chat.push({
        messageCountSee,
        appointMentId,
        chatDetails: chatModule,
      });
    }

    let Rchat = Ruser.chat.find((chat) => chat.appointMentId === appointMentId);

    if (Rchat) {
      Rchat.chatDetails.push(RchatModule);
      Rchat.messageCountSee = (parseInt(Rchat.messageCountSee) || 0) + 1; // Increase messageCountSee by 1
    } else {
      Ruser.chat.push({
        messageCountSee,
        appointMentId: appointMentId,
        chatDetails: RchatModule,
      });
    }

    Cuser = await Cuser.save();
    Ruser = await Ruser.save();

    res.json(Cuser);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

chatRouter.post("/get/ListChat", async (req, res) => {
  try {
    const { isDoctor, currentId, reciverId, appointMentId } = req.body;
    console.log(req.body);
    if (typeof isDoctor !== "boolean" || !currentId || !reciverId) {
      return res.status(400).json({ msg: "Invalid request parameters" });
    }

    let Ruser, Cuser, Cchats;

    if (isDoctor) {
      Ruser = await userModule.findById(reciverId); //
      if (!Ruser) {
        return res.status(400).json({ msg: "User not found" });
      }
      Cuser = await doctorModule.findById(currentId); //
    } else {
      Ruser = await doctorModule.findById(reciverId);
      if (!Ruser) {
        return res.status(400).json({ msg: "Doctor not found" });
      }
      Cuser = await userModule.findById(currentId);
    }

    Cchats = Cuser.chat.filter((chat) => chat.appointMentId === appointMentId);

    res.json(Cchats);
  } catch (error) {
    console.error("Error:", error);
    res.status(500).json({ error: "Internal server error" });
  }
});
chatRouter.post("/setZero/messages/Doctor", async (req, res) => {
  try {
    const { appointMentId } = req.body;

    const updatedDoctor = await doctorModule.findOneAndUpdate(
      {
        "chat.appointMentId": appointMentId,
      },
      {
        $set: { "chat.$.messageCountSee": "0" },
      },
      { new: true }
    );

    if (!updatedDoctor) {
      return res.status(400).json({ msg: "Doctor not found" });
    }

    res.json({ msg: "Message count updated successfully" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ msg: "Server Error" });
  }
});
chatRouter.post("/setZero/messages/User", async (req, res) => {
  try {
    const { appointMentId } = req.body;

    const updatedUser = await userModule.findOneAndUpdate(
      {
        "chat.appointMentId": appointMentId,
      },
      {
        $set: { "chat.$.messageCountSee": "0" },
      },
      { new: true }
    );

    if (!updatedUser) {
      return res.status(400).json({ msg: "User not found" });
    }

    res.json({ msg: "Message count updated successfully" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ msg: "Server Error" });
  }
});
chatRouter.post("/get/MessageCount/doctor", async (req, res) => {
  try {
    const { appointMentId } = req.body;

    const doctor = await doctorModule.findOne(
      {
        "chat.appointMentId": appointMentId,
      },
      { "chat.$": 1 }
    );

    if (!doctor) {
      return res.status(400).json({ msg: "Doctor not found" });
    }

    const messageCountSee = doctor.chat[0].messageCountSee;

    res.json({ messageCountSee: messageCountSee, doctor: doctor });
  } catch (error) {
    console.error(error);
    res.status(500).json({ msg: "Server Error" });
  }
});
chatRouter.post("/get/MessageCount/user", async (req, res) => {
  try {
    const { appointMentId } = req.body;

    const user = await userModule.findOne(
      {
        "chat.appointMentId": appointMentId,
      },
      { "chat.$": 1 }
    );

    if (!user) {
      return res.status(400).json({ msg: "user not found" });
    }

    const messageCountSee = user.chat[0].messageCountSee;

    res.json({ messageCountSee: messageCountSee, user: user });
  } catch (error) {
    console.error(error);
    res.status(500).json({ msg: "Server Error" });
  }
});

module.exports = chatRouter;
