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
    const { currentId, reciverId, message, time } = req.body;

    let chatModule = new ChatDetail({
      reciverId,
      message,
      time,
      itsMe: true,
    });
    let RchatModule = new ChatDetail({
      reciverId,
      message,
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

    let Cchat = Cuser.chat.find((chat) => chat.reciverId === reciverId);

    if (Cchat) {
      Cchat.chatDetails.push(chatModule);
    } else {
      Cuser.chat.push({ reciverId, chatDetails: chatModule });
    }

    let Rchat = Ruser.chat.find((chat) => chat.reciverId === req.user);

    if (Rchat) {
      Rchat.chatDetails.push(RchatModule);
    } else {
      Ruser.chat.push({ reciverId: reciverId, chatDetails: RchatModule });
    }

    Cuser = await Cuser.save();
    Ruser = await Ruser.save();

    res.json(Cuser);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});
module.exports = chatRouter;
