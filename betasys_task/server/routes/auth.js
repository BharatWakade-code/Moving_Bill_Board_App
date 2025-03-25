const express = require("express");
const User = require("../module/user_module");

const authRouter = express.Router();

authRouter.post("/singup", async (req, res) => {
  try {
    const { name } = req.body;
    const exists = await User.findOne({ mobile });
    if (exists) {
      res.status(400).json({
        msg: "Mobile number all ready exists !",
      });
    }

    let user = new User({
      mobile,
      address,
      name,
    });

    user = await user.save();
    res.json(user);
  } catch (e) {
    res.json({ Error: e });
  }
});
authRouter.get("/items", (req, res) => {
  res.json({ name: "helow" });
});
module.exports = authRouter;
