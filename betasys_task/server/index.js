const express = require("express");
const mongoose = require("mongoose");

const app = express();
const authRouter = require("./routes/auth");


//Connection to mongoDB
const DB =
  "mongodb+srv://bharat:bharat1234@cluster0.mdz6b.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";
mongoose
  .connect(DB)
  .then(() => console.log("connected to mongooes"))
  .catch(() => console.log("error mongooess"));

//MiddleWare
app.use(express.json());
app.use(authRouter);

app.get("/", function (req, res) {
  res.json({ name: "bharat" });
});

app.listen(3000, "0.0.0.0", () => {
  console.log("Server is running on port 3000");
});
