const paypal = require("@paypal/checkout-server-sdk");
const { PAYPAL_CONFIG } = require("../config/app.config");

const environment = new paypal.core.SandboxEnvironment(
    PAYPAL_CONFIG.PAYPAL_CLIENT_ID,
    PAYPAL_CONFIG.PAYPAL_CLIENT_SECRET
);
const client = new paypal.core.PayPalHttpClient(environment);

module.exports = client;
