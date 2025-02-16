const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");
const bcrypt = require('bcrypt');
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");
const PORT = process.env.PORT || 3000;;
const app = express();
const Db = "mongodb+srv://manojchebrolu72:manojchebrolu72@cluster0.zoxcc.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

// Middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

// MongoDB Connection
mongoose

  .connect(Db)
  .then(() => {
    console.log("Database connection successful");
  })
  .catch((e) => {
    console.error("Database connection error:", e.message);
  });

// Start the server
app.listen(PORT,() => {
  console.log("Server running at port " + PORT);
});
