require('dotenv').config();

const MONGO_DB_CONFIG = {
  DB: process.env.MONGO_DB_URI || "mongodb+srv://renatomuiambo24:B6nQmkm9FKFye4IJ@cluster0.zsfv2xd.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0",
  PAGE_SIZE: parseInt(process.env.PAGE_SIZE) || 10,
};

const PAYPAL_CONFIG = {
  PAYPAL_CLIENT_ID: "AWyJ_ftqZSCAw8cURb40BW1-FhN02fLSB_s1uHYIxTeNj0oEchMm-2K-CHPE0Lir2pLRyHr2h8hg2Hof",
  PAYPAL_CLIENT_SECRET: "EDcGtS39NOI1RYXwusoTC9_55WL3GbdJwlJZ8UoZq6hMKuzF-3TfcKegYQqWswlZ5dVCoE6Ib1nMEAFp",
  CURRENCY: "USD"
}

module.exports = { MONGO_DB_CONFIG, PAYPAL_CONFIG };
