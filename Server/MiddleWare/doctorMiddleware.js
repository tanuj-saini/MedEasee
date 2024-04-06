const jwt = require("jsonwebtoken");
const authDoctor = async (req, res, next) => {
  try {
    const token = req.header("x-auth-token-D");
    if (!token) {
      return res.status(401).json({ msg: "No Auth taken" });
    }
    const verified = jwt.verify(token, "passwordKeyD");
    if (!verified) {
      return res.status(401).json({ msg: "token invalid" });
    }
    req.user = verified.id;
    req.token = token;
    next();
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
};
module.exports = authDoctor;
