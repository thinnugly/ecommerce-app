require('dotenv').config();
const express = require("express");
const app = express();
const mongoose = require("mongoose");
const { MONGO_DB_CONFIG } = require("./config/app.config");
const erros = require("./middleware/errors.js");
const swaggerUi = require("swagger-ui-express"),
  swaggerDocument = require("./swagger.json");
const cors = require('cors');

mongoose.Promise = global.Promise;
mongoose
  .connect(MONGO_DB_CONFIG.DB)
  .then(
    () => {
      console.log("Database connected.");
    },
    (error) => {
      console.log("Database can't be connected: " + error);
    }
  );

app.use(express.json());
app.use(cors());
app.use("/uploads", express.static("uploads"));
app.use("/api", require("./routes/app.routes.js"));
app.use(erros.errorHandler);
app.use("/api-docs", swaggerUi.serve, swaggerUi.setup(swaggerDocument));

app.listen(process.env.PORT || 4000, function () {
  console.log("Ready to Go!");
});
