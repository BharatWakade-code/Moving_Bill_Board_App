// const express = require("express");
// const mongoose = require("mongoose");

// const app = express();
// const authRouter = require("./routes/auth");


// //Connection to mongoDB
// const DB =
//   "mongodb+srv://bharat:bharat1234@cluster0.mdz6b.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";
// mongoose
//   .connect(DB)
//   .then(() => console.log("connected to mongooes"))
//   .catch(() => console.log("error mongooess"));

// //MiddleWare
// app.use(express.json());
// app.use(authRouter);

// app.get("/", function (req, res) {
//   res.json({ name: "bharat" });
// });

// app.listen(3000, "0.0.0.0", () => {
//   console.log("Server is running on port 3000");
// });


const express = require("express");
const http = require("http");
const cors = require("cors");
const { Server } = require("socket.io");

const app = express();
app.use(cors());

const server = http.createServer(app);

const io = new Server(server, {
  cors: {
    origin: "*",
  },
});

io.on("connection", (socket) => {
  console.log(`✅ New client connected: ${socket.id}`);

  socket.on("send_text", (data) => {
    console.log("Text received:", data);
    io.emit("receive_text", data);
  });

  socket.on("send_image", (data) => {
    console.log("Image received:", data);
    io.emit("receive_image", data);
  });

  socket.on("clear", () => {
    console.log("Clear display requested.");
    io.emit("clear_display");
  });

  socket.on("disconnect", () => {
    console.log(`❌ Client disconnected: ${socket.id}`);
  });
});

server.listen(3000, () => {
  console.log("🚀 Server running at http://localhost:3000");
});
