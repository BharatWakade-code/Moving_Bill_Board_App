const express = require("express");
const User = require("../module/user_module");
const authRouter = express.Router();
const bcrypt = require("bcrypt");

authRouter.post("/login", async (req, res) => {
  try {
    const { mobile, password } = req.body;

    if (!mobile || !password) {
      return res.status(400).json({
        success: false,
        message: "Mobile number and password are required",
      });
    }

    const existingUser = await User.findOne({ mobile });

    if (!existingUser) {
      return res.json({
        success: false,
        message: "Mobile number is not registered! Please register first.",
      });
    }

    // Compare hashed password
    const isPasswordValid = await bcrypt.compare(
      password,
      existingUser.password
    );

    if (!isPasswordValid) {
      return res.json({
        success: false,
        message: "Invalid password! Please try again.",
      });
    }

    res.status(200).json({
      success: true,
      message: "Login successful",
      user: existingUser, // Avoid sending sensitive user data
    });
  } catch (error) {
    console.error("Login error:", error);
    res.status(500).json({
      success: false,
      message: "Internal server error",
    });
  }
});

authRouter.post("/signup", async (req, res) => {
  try {
    console.log("Received Data:", req.body);

    const { name, mobile, password } = req.body;

    if (!name || !mobile || !password) {
      return res.status(200).json({
        success: false,
        message: "Mobile number, name, and password are required",
      });
    }

    const existingUser = await User.findOne({ mobile });
    if (existingUser) {
      return res.status(200).json({
        success: false,
        message: "Mobile is already registered! Retry with another number",
      });
    }
    const saltRounds = 10;
    const hashedPassword = await bcrypt.hash(password, saltRounds);
    console.log("Hashed Password:", hashedPassword); 
    const newUser = new User({ name, mobile, hashedPassword });
    const savedUser = await newUser.save();

    console.log("Saved User:", savedUser);

    res.status.json({
      success: true,
      message: "User registered successfully",
      user: {
        id: savedUser._id,
        name: savedUser.name,
        mobile: savedUser.mobile,
      },
    });
  } catch (error) {
    console.error("User Register error:", error);
    res.status(500).json({ success: false, message: "Internal server error" });
  }
});

module.exports = authRouter;
