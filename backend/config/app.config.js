require('dotenv').config();

const MONGO_DB_CONFIG = {
  DB: process.env.MONGO_DB_URI,
  PAGE_SIZE: parseInt(process.env.PAGE_SIZE) || 10,
};

module.exports = { MONGO_DB_CONFIG };
