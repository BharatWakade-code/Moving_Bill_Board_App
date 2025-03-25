const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
  name: {
    Type: String,
  },
  mobile: {
    Type: String,
  },
  address: {
    Type: String,
  },
});

const User = mongoose.model("user", userSchema);

module.exports = User;
