const paypal = require("@paypal/checkout-server-sdk");
const client = require("../services/paypal.service");
const { order } = require("../models/order.model");
const { payment } = require("../models/payment.model");
const { PAYPAL_CONFIG } = require("../config/app.config");
const axios = require("axios");


async function convertMZNtoUSD(amountMZN) {
    try {
        const apiKey = '1108d23e709f9ee7d505719c';
        const response = await axios.get(`https://v6.exchangerate-api.com/v6/${apiKey}/latest/MZN`);

        const rateMZNToUSD = response.data.conversion_rates.USD;
        if (!rateMZNToUSD) {
            throw new Error("Taxa MZN→USD não encontrada");
        }

        const amountUSD = (amountMZN * rateMZNToUSD).toFixed(2);
        return amountUSD;
    } catch (error) {
        console.error("Erro ao converter moeda:", error.message);
        throw new Error("Erro ao converter MZN para USD.");
    }
}



async function createPaypalOrder(orderId) {
    const orderM = await order.findById(orderId);
    if (!orderM) throw new Error("Order not found");

    const request = new paypal.orders.OrdersCreateRequest();
    const totalUSD = await convertMZNtoUSD(orderM.grandTotal);
    request.requestBody({
        intent: "CAPTURE",
        purchase_units: [
            {
                amount: {
                    currency_code: PAYPAL_CONFIG.CURRENCY,
                    value: totalUSD,
                },
            },
        ],
        application_context: {
            return_url: "http://localhost:4000/api/orders/payment-success",
            cancel_url: "http://localhost:4000/api/orders/payment-cancel",
        }


    });

    const response = await client.execute(request);

    const paymentM = new payment({
        orderId,
        paypalOrderId: response.result.id,
        amount: orderM.grandTotal,
    });

    await paymentM.save();

    return response.result;
}

async function capturePaypalOrder(paypalOrderId) {
    const request = new paypal.orders.OrdersCaptureRequest(paypalOrderId);
    request.requestBody({});

    const response = await client.execute(request);
    const status = response.result.status;

    const paymentM = await payment.findOne({ paypalOrderId });
    if (!paymentM) throw new Error("Pagamento não encontrado");

    if (status === "COMPLETED") {
        paymentM.status = "COMPLETED";
        paymentM.transactionID = response.result.id;
        paymentM.payerEmail = response.result.payer.email_address;
        paymentM.payerID = response.result.payer.payer_id;
        await paymentM.save();

        await order.findByIdAndUpdate(paymentM.orderId, {
            orderStatus: "paid",
            transactionID: paymentM.transactionID,
        });
    } else {
        paymentM.status = "FAILED";
        await paymentM.save();
    }

    return status;
}

async function getPaymentStatus(params) {
    if (!params.orderId) {
      throw new Error('orderId is required.');
    }
    if (!params.userId) {
      throw new Error('userId is required.');
    }
  
    try {
      const paymentRecord = await payment.findOne({
        orderId: params.orderId,
      });
  
      return paymentRecord;
    } catch (error) {
      console.error('Erro ao obter o pagamento:', error);
      throw error;
    }
  }
  


module.exports = { createPaypalOrder, capturePaypalOrder, getPaymentStatus };
